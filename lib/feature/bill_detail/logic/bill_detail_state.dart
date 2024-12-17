part of 'bill_detail_cubit.dart';

class BillDetailState extends Equatable {
  const BillDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isShowingBackgroundAppBar = false,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isShowingBackgroundAppBar;

  BillDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isShowingBackgroundAppBar,
  }) {
    return BillDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isShowingBackgroundAppBar:
          isShowingBackgroundAppBar ?? this.isShowingBackgroundAppBar,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isShowingBackgroundAppBar,
      ];
}
