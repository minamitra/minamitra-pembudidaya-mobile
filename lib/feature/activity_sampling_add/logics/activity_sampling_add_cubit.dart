import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_sampling/activity_sampling_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_sampling_add/repositories/add_sampling_payload.dart';

part 'activity_sampling_add_state.dart';

class ActivitySamplingAddCubit extends Cubit<ActivitySamplingAddState> {
  ActivitySamplingAddCubit(this.samplingService, this.cdnService)
      : super(const ActivitySamplingAddState());

  final ActivitySamplingService samplingService;
  final CdnService cdnService;

  Future<void> addSampling(
      AddSamplingPayload payload, List<File> attachment) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      List<String> attachmentLink = await uploadImage(attachment);
      payload.attachmentJsonArray = attachmentLink;
      await samplingService.addSampling(payload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
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
