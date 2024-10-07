part of 'add_pond_first_step_cubit.dart';

class AddPondFirstStepState extends Equatable {
  const AddPondFirstStepState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.pondName,
    this.pondLength,
    this.pondWidth,
    this.pondDepth,
  });

  final GlobalState status;
  final String errorMessage;
  final String? pondName;
  final double? pondLength;
  final double? pondWidth;
  final double? pondDepth;

  AddPondFirstStepState copyWith({
    GlobalState? status,
    String? errorMessage,
    String? pondName,
    double? pondLength,
    double? pondWidth,
    double? pondDepth,
  }) {
    return AddPondFirstStepState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pondName: pondName ?? this.pondName,
      pondLength: pondLength ?? this.pondLength,
      pondWidth: pondWidth ?? this.pondWidth,
      pondDepth: pondDepth ?? this.pondDepth,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        pondName ?? "",
        pondLength ?? 0,
        pondWidth ?? 0,
        pondDepth ?? 0,
      ];
}
