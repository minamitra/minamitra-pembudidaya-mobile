import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/profile/profile_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/profile_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/repositories/update_profile_payload.dart';

part 'profile_member_state.dart';

class ProfileMemberCubit extends Cubit<ProfileMemberState> {
  final ProfileService profileService;
  final CdnService cdnService;

  ProfileMemberCubit(this.profileService, this.cdnService)
      : super(const ProfileMemberState());

  Future<void> init() async {}

  void changeTabIndex(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(
      status: GlobalState.loaded,
      tabIndex: index,
    ));
  }

  void getProfile() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await profileService.detailProfile();
      emit(state.copyWith(
        status: GlobalState.loaded,
        profile: response.data.data,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateProfile(UpdateProfilePayload payload, File profileImage) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final url = await cdnService.uploadImage(profileImage);
      payload.imageUrl = url.data.data!.fileuri!;
      payload.ktpUrl = state.profile!.ktpUrl;
      payload.ekusukaUrl = state.profile!.ekusukaUrl;
      await profileService.updateProfile(payload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.loading));
      final response = await profileService.detailProfile();
      emit(state.copyWith(
        status: GlobalState.loaded,
        profile: response.data.data,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateAttachmentProfile(File ktpImage, File ekusukaImage) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final ktpUrl = await cdnService.uploadImage(ktpImage);
      final ekusukaUrl = await cdnService.uploadImage(ekusukaImage);
      final payload = UpdateProfilePayload(
        nik: state.profile!.nik,
        name: state.profile!.name,
        email: state.profile!.email,
        mobilephone: state.profile!.mobilephone,
        birthPlace: state.profile!.birthPlace,
        birthDate: AppConvertDateTime().ymdDash(state.profile!.birthDate!),
        gender: state.profile!.gender,
        job: state.profile!.job,
        imageUrl: state.profile!.imageUrl,
        ktpUrl: ktpUrl.data.data!.fileuri,
        ekusukaUrl: ekusukaUrl.data.data!.fileuri,
      );
      await profileService.updateProfile(payload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.loading));
      final response = await profileService.detailProfile();
      emit(state.copyWith(
        status: GlobalState.loaded,
        profile: response.data.data,
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
  }
}
