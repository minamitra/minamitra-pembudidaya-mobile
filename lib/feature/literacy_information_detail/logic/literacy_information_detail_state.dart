part of 'literacy_information_detail_cubit.dart';

class LiteracyInformationDetailState extends Equatable {
  const LiteracyInformationDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.data,
  });

  final GlobalState status;
  final String errorMessage;
  final LiteracyInformationResponseData? data;

  LiteracyInformationDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    LiteracyInformationResponseData? data,
  }) {
    return LiteracyInformationDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        data ?? '',
      ];
}
