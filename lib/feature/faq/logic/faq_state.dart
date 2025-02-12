part of 'faq_cubit.dart';

class FaqState extends Equatable {
  const FaqState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.faqListResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final FaqListResponse? faqListResponse;

  FaqState copyWith({
    GlobalState? status,
    String? errorMessage,
    FaqListResponse? faqListResponse,
  }) {
    return FaqState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      faqListResponse: faqListResponse ?? this.faqListResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        faqListResponse ?? '',
      ];
}
