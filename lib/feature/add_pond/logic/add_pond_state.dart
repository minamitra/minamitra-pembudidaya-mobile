part of 'add_pond_cubit.dart';

class AddPondState extends Equatable {
  const AddPondState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.index = 0,
    this.updatePondPayload,
  });

  final GlobalState status;
  final String errorMessage;
  final int index;
  final UpdatePondPayload? updatePondPayload;

  AddPondState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? index,
    UpdatePondPayload? updatePondPayload,
  }) {
    return AddPondState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      index: index ?? this.index,
      updatePondPayload: updatePondPayload ?? this.updatePondPayload,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        index,
        updatePondPayload,
      ];
}
