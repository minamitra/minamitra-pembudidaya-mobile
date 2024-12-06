part of 'history_point_cubit.dart';

class HistoryPointState extends Equatable {
  const HistoryPointState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.selectedFilter = 'Semua',
    this.selectedDate,
  });

  final GlobalState status;
  final String errorMessage;
  final String selectedFilter;
  final DateTime? selectedDate;

  HistoryPointState copyWith({
    GlobalState? status,
    String? errorMessage,
    String? selectedFilter,
    DateTime? selectedDate,
  }) {
    return HistoryPointState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedDate: selectedDate,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        selectedFilter,
        selectedDate ?? DateTime.now(),
      ];
}
