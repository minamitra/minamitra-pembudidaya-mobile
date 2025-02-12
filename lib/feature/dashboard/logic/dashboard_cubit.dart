import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/profile/profile_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.profileService) : super(const DashboardState());

  final ProfileService profileService;

  Future<void> requestMember(BuildContext context) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final response = await profileService.requestMember();
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      if (response.meta.status == 200) {
        emit(state.copyWith(status: GlobalState.successSubmit));
      } else {
        AppTopSnackBar(context)
            .showInfo(response.meta.message ?? 'Terjadi kesalahan request');
      }
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
