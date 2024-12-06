part of 'add_another_finance_cubit.dart';

class AddAnotherFinanceState extends Equatable {
  const AddAnotherFinanceState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.selectedDate,
    this.images = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final DateTime? selectedDate;
  final List<String> images;

  AddAnotherFinanceState copyWith({
    GlobalState? status,
    String? errorMessage,
    DateTime? selectedDate,
    List<String>? images,
  }) {
    return AddAnotherFinanceState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDate: selectedDate ?? this.selectedDate,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        selectedDate ?? DateTime.now(),
        images,
      ];
}
