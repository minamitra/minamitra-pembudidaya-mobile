part of 'resume_detail_cubit.dart';

class ResumeDetailState extends Equatable {
  const ResumeDetailState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.isShowingCycleSection = true,
    this.isShowingHarvestInfoSection = true,
    this.isShowingCultivationAssessmentSection = true,
    this.isShowingFeedSection = true,
    this.isShowingCultivationResultsSection = true,
    this.companionNotesResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final bool isShowingCycleSection;
  final bool isShowingHarvestInfoSection;
  final bool isShowingCultivationAssessmentSection;
  final bool isShowingFeedSection;
  final bool isShowingCultivationResultsSection;
  final CompanionNotesResponse? companionNotesResponse;

  ResumeDetailState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? isShowingCycleSection,
    bool? isShowingHarvestInfoSection,
    bool? isShowingCultivationAssessmentSection,
    bool? isShowingFeedSection,
    bool? isShowingCultivationResultsSection,
    CompanionNotesResponse? companionNotesResponse,
  }) {
    return ResumeDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isShowingCycleSection:
          isShowingCycleSection ?? this.isShowingCycleSection,
      isShowingHarvestInfoSection:
          isShowingHarvestInfoSection ?? this.isShowingHarvestInfoSection,
      isShowingCultivationAssessmentSection:
          isShowingCultivationAssessmentSection ??
              this.isShowingCultivationAssessmentSection,
      isShowingFeedSection: isShowingFeedSection ?? this.isShowingFeedSection,
      isShowingCultivationResultsSection: isShowingCultivationResultsSection ??
          this.isShowingCultivationResultsSection,
      companionNotesResponse:
          companionNotesResponse ?? this.companionNotesResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isShowingCycleSection,
        isShowingHarvestInfoSection,
        isShowingCultivationAssessmentSection,
        isShowingFeedSection,
        isShowingCultivationResultsSection,
        companionNotesResponse ?? CompanionNotesResponse(),
      ];
}
