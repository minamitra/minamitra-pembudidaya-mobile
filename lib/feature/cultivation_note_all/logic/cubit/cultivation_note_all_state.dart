part of 'cultivation_note_all_cubit.dart';

class CultivationNoteAllState extends Equatable {
  const CultivationNoteAllState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.data = const [],
    this.companionName = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<CompanionNotesResponseData>? data;
  final List<String>? companionName;

  CultivationNoteAllState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<CompanionNotesResponseData>? data,
    List<String>? companionName,
  }) {
    return CultivationNoteAllState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      companionName: companionName ?? this.companionName,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        data ?? [],
        companionName ?? [],
      ];
}
