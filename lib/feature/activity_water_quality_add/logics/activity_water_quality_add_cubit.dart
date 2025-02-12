import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/water_color_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/water_weather_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_water_quality/activity_water_quality_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/repositories/add_water_quality_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_water_quality_add/repositories/update_water_quality_payload.dart';

part 'activity_water_quality_add_state.dart';

class ActivityWaterQualityAddCubit extends Cubit<ActivityWaterQualityAddState> {
  ActivityWaterQualityAddCubit(
    this.treatmentService,
    this.cdnService,
    this.publicService,
  ) : super(const ActivityWaterQualityAddState());

  final ActivityWaterQualityService treatmentService;
  final CdnService cdnService;
  final PublicService publicService;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final waterColor = await publicService.waterColor();
      final waterWeather = await publicService.waterWeather();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          waterColor: waterColor.data.data,
          waterWeather: waterWeather.data.data,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> addWaterQuality(
    AddWaterQualityPayload payload,
    List<File> attachment,
  ) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      List<String> attachmentLink = await uploadImage(attachment);
      payload.attachmentJsonArray = attachmentLink;
      await treatmentService.addWaterQuality(payload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateWaterQuality(
    UpdateWaterQualityPayload payload,
    List<File> attachment,
  ) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      List<String> attachmentLink = await uploadImage(attachment);
      payload.attachmentJsonArray = attachmentLink;
      await treatmentService.updateWaterQuality(payload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<List<String>> uploadImage(List<File> attachmentJsonArray) async {
    List<String> attachmentLink = [];
    await Future.forEach(attachmentJsonArray, (image) async {
      final url = await cdnService.uploadImage(image);
      attachmentLink.add(url.data.data!.fileuri!);
    });
    return attachmentLink;
  }
}
