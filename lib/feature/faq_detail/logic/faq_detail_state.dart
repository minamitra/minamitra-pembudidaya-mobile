part of 'faq_detail_cubit.dart';

class FaqDetailState extends Equatable {
  const FaqDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.faqDetailData,
  });

  final GlobalState status;
  final String errorMessage;
  final FaqListResponseData? faqDetailData;

  FaqDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    FaqListResponseData? faqDetailData,
  }) {
    return FaqDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      faqDetailData: faqDetailData ?? this.faqDetailData,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        faqDetailData ?? '',
      ];
}
