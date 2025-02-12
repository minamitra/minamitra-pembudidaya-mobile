part of 'list_bill_cubit.dart';

class ListBillState extends Equatable {
  const ListBillState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.filter = 'Semua Tagihan',
    this.billResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final String filter;
  final BillResponse? billResponse;

  ListBillState copyWith({
    GlobalState? status,
    String? errorMessage,
    String? filter,
    BillResponse? billResponse,
  }) {
    return ListBillState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
      billResponse: billResponse ?? this.billResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        filter,
        billResponse ?? '',
      ];
}
