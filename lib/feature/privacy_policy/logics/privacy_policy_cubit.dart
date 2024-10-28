import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/term_condition/term_condition_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/privacy_policy/repositories/privacy_policy_response.dart';

part 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final TermConditionService service;

  PrivacyPolicyCubit(this.service) : super(const PrivacyPolicyState());

  void getPrivacyPolicy() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getPrivacyPolicy();
      emit(state.copyWith(
        status: GlobalState.loaded,
        privacyPolicy: response.data.data,
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
