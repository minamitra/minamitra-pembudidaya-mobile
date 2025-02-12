import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/literacy_information_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/literacy_information/literacy_information_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'literacy_information_detail_state.dart';

class LiteracyInformationDetailCubit
    extends Cubit<LiteracyInformationDetailState> {
  LiteracyInformationDetailCubit(this.service)
      : super(const LiteracyInformationDetailState());

  final LiteracyInformationService service;

  Future<void> init(String id) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.literacyInformationDetail(id: id);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          data: response.data,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
