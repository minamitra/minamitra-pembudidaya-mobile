import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit(this.pondService) : super(const ActivityState());

  final PondService pondService;
  bool isLastPage = false;

  Future<void> init({String limit = '7'}) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      isLastPage = false;
      BaseResponse<PondResponse> response =
          await pondService.getPonds(limit: limit);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          pondReponse: response.data.data,
          currentPage: response.data.pagination?.current,
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

  Future<void> loadMoreData() async {
    emit(state.copyWith(status: GlobalState.loadMore));
    try {
      if (!isLastPage) {
        final response = await pondService.getPonds(
          page: ((state.currentPage ?? 1) + 1).toString(),
        );
        isLastPage =
            response.data.pagination?.totalPage == (state.currentPage ?? 1) + 1;
        emit(
          state.copyWith(
            status: GlobalState.loaded,
            pondReponse: (state.pondReponse ?? []) + (response.data.data ?? []),
            currentPage: response.data.pagination?.current,
          ),
        );
      } else {
        emit(state.copyWith(status: GlobalState.loaded));
      }
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message.toString(),
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
}
