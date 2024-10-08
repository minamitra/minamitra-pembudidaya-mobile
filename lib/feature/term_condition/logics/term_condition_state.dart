part of 'term_condition_cubit.dart';

class TermConditionState extends Equatable {
  const TermConditionState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.termCondition,
  });

  final GlobalState status;
  final String errorMessage;
  final TermConditionResponseData? termCondition;

  TermConditionState copyWith({
    GlobalState? status,
    String? errorMessage,
    TermConditionResponseData? termCondition,
  }) {
    return TermConditionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      termCondition: termCondition ?? this.termCondition,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        termCondition,
      ];
}
