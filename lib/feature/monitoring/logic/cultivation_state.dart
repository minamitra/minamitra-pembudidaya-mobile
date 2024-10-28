part of 'cultivation_cubit.dart';

class CultivationState extends Equatable {
  const CultivationState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.data,
    this.companionNotesData,
  });

  final GlobalState status;
  final String errorMessage;
  final GraphResponseData? data;
  final CompanionNotesResponse? companionNotesData;

  CultivationState copyWith({
    GlobalState? status,
    String? errorMessage,
    GraphResponseData? data,
    CompanionNotesResponse? companionNotesData,
  }) {
    return CultivationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      companionNotesData: companionNotesData ?? this.companionNotesData,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        data ?? GraphResponseData(),
        companionNotesData ?? CompanionNotesResponse(),
      ];
}
