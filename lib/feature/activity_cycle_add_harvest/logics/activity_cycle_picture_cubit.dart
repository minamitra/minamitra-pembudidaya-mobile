import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

class ActivityCyclePictureCubit extends Cubit<ActivityCyclePictureState> {
  ActivityCyclePictureCubit(
    this.cdnService,
  ) : super(ActivityCyclePictureState());

  final CdnService cdnService;

  void initImage({List<String>? image}) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(
      status: GlobalState.loaded,
      images: image != null ? [...image] : [],
    ));
  }

  Future<void> setImage(File image) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final response = await cdnService.uploadImage(image);
      emit(state.copyWith(
        status: GlobalState.hideDialogLoading,
        images: [...state.images ?? [], response.data.data?.fileuri ?? ""],
      ));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }

    // final List<Uint8List> listImage = [...state ?? []];
    // if (listImage.length < 3) {
    //   listImage.add(image);
    // } else {
    //   listImage.removeAt(0);
    //   listImage.add(image);
    // }
    // emit(listImage);
  }

  void removeImage(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<String> listImage =
        state.images != null ? [...state.images!] : [];
    listImage.removeAt(index);
    emit(state.copyWith(images: listImage, status: GlobalState.loaded));
  }
}

class ActivityCyclePictureState {
  ActivityCyclePictureState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.images = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<String>? images;

  ActivityCyclePictureState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<String>? images,
  }) {
    return ActivityCyclePictureState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      images: images ?? this.images,
    );
  }
}
