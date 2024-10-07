import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/activity_incident/activity_incident_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/repositories/add_incident_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_add/repositories/update_incicent_payload.dart';

part 'activity_incident_add_state.dart';

class ActivityIncidentAddCubit extends Cubit<ActivityIncidentAddState> {
  ActivityIncidentAddCubit(this.incidentService, this.cdnService)
      : super(const ActivityIncidentAddState());

  final ActivityIncidentService incidentService;
  final CdnService cdnService;

  Future<void> addIncident(
      AddIncidentPayload payload, List<File> attachment) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      List<String> attachmentLink = await uploadImage(attachment);
      payload.attachmentJsonArray = attachmentLink;
      await incidentService.addIncident(payload);
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

  Future<void> updateIncident(
      UpdateIncidentPayload payload, List<File> attachment) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      List<String> attachmentLink = await uploadImage(attachment);
      payload.attachmentJsonArray = attachmentLink;
      await incidentService.updateIncident(payload);
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
