part of 'cultivation_cubit.dart';

class CultivationState extends Equatable {
  const CultivationState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.data,
    this.companionNotesData,
    this.commentReaded = const [],
    this.detailParameterResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final GraphResponseData? data;
  final CompanionNotesResponse? companionNotesData;
  final List<String>? commentReaded;
  final DetailParameterResponse? detailParameterResponse;

  CultivationState copyWith({
    GlobalState? status,
    String? errorMessage,
    GraphResponseData? data,
    CompanionNotesResponse? companionNotesData,
    List<String>? commentReaded,
    DetailParameterResponse? detailParameterResponse,
  }) {
    return CultivationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      companionNotesData: companionNotesData ?? this.companionNotesData,
      commentReaded: commentReaded ?? this.commentReaded,
      detailParameterResponse:
          detailParameterResponse ?? this.detailParameterResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        data ?? GraphResponseData(),
        companionNotesData ?? CompanionNotesResponse(),
        detailParameterResponse ?? DetailParameterResponse(),
        [],
      ];
}
