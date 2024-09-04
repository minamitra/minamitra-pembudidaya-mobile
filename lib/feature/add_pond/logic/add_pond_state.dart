part of 'add_pond_cubit.dart';

class AddPondState extends Equatable {
  const AddPondState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.index = 0,
  });

  final GlobalState status;
  final String errorMessage;
  final int index;

  AddPondState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? index,
  }) {
    return AddPondState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        index,
      ];
}
