part of 'history_point_cubit.dart';

class HistoryPointState extends Equatable {
  const HistoryPointState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.selectedFilter = -1,
  });

  final GlobalState status;
  final String errorMessage;
  final int selectedFilter;

  HistoryPointState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? selectedFilter,
  }) {
    return HistoryPointState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        selectedFilter,
      ];
}
