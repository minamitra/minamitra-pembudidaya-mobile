part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  const TransactionState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.waitingDatas,
    this.processDatas,
    this.doneDatas,
    this.cancelDatas,
  });

  final GlobalState status;
  final String errorMessage;
  final TransactionItemResponse? waitingDatas;
  final TransactionItemResponse? processDatas;
  final TransactionItemResponse? doneDatas;
  final TransactionItemResponse? cancelDatas;

  TransactionState copyWith({
    GlobalState? status,
    String? errorMessage,
    TransactionItemResponse? waitingDatas,
    TransactionItemResponse? processDatas,
    TransactionItemResponse? doneDatas,
    TransactionItemResponse? cancelDatas,
  }) {
    return TransactionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      waitingDatas: waitingDatas ?? this.waitingDatas,
      processDatas: processDatas ?? this.processDatas,
      doneDatas: doneDatas ?? this.doneDatas,
      cancelDatas: cancelDatas ?? this.cancelDatas,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        waitingDatas ?? '',
        processDatas ?? '',
        doneDatas ?? '',
        cancelDatas ?? '',
      ];
}
