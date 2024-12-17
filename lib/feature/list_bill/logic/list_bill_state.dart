part of 'list_bill_cubit.dart';

class ListBillState extends Equatable {
  const ListBillState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.filter = 'Semua Tagihan',
  });

  final GlobalState status;
  final String errorMessage;
  final String filter;

  ListBillState copyWith({
    GlobalState? status,
    String? errorMessage,
    String? filter,
  }) {
    return ListBillState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        filter,
      ];
}
