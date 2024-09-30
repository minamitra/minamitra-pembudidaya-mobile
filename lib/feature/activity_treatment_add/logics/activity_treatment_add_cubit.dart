import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_treatment/activity_treatment_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/repositories/add_treatment_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_add/repositories/update_treatment_payload.dart';

part 'activity_treatment_add_state.dart';

class ActivityTreatmentAddCubit extends Cubit<ActivityTreatmentAddState> {
  ActivityTreatmentAddCubit(this.treatmentService, this.cdnService)
      : super(const ActivityTreatmentAddState());

  final ActivityTreatmentService treatmentService;
  final CdnService cdnService;

  Future<void> addTreatment(
      AddTreatmentPayload payload, List<File> attachment) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      List<String> attachmentLink = await uploadImage(attachment);
      payload.attachmentJsonArray = attachmentLink;
      await treatmentService.addTreatment(payload);
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

  Future<void> updateTreatment(
      UpdateTreatmentPayload payload, List<File> attachment) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      List<String> attachmentLink = await uploadImage(attachment);
      payload.attachmentJsonArray = attachmentLink;
      await treatmentService.updateTreatment(payload);
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
