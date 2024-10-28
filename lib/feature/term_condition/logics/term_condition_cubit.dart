import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/term_condition/term_condition_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/term_condition/repositories/term_condition_response.dart';

part 'term_condition_state.dart';

class TermConditionCubit extends Cubit<TermConditionState> {
  final TermConditionService service;

  TermConditionCubit(this.service) : super(const TermConditionState());

  void getTermCondition() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getTermCondition();
      emit(state.copyWith(
        status: GlobalState.loaded,
        termCondition: response.data.data,
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
}
