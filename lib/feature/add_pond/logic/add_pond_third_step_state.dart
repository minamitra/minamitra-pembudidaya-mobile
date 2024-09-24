part of 'add_pond_third_step_cubit.dart';

class AddPondThirdStepState extends Equatable {
  const AddPondThirdStepState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
  });

  final GlobalState status;
  final String errorMessage;

  AddPondThirdStepState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return AddPondThirdStepState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
      ];
}
