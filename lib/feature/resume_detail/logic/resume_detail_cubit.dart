import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';

part 'resume_detail_state.dart';

class ResumeDetailCubit extends Cubit<ResumeDetailState> {
  ResumeDetailCubit(this.cycleService) : super(const ResumeDetailState());

  final CycleService cycleService;

  Future<void> init(String fishPondCycleID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final companionNotesResponse =
          await cycleService.getCompanionNotes(pondCycleID: fishPondCycleID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          companionNotesResponse: companionNotesResponse.data,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void toggleCycleSection() {
    emit(state.copyWith(isShowingCycleSection: !state.isShowingCycleSection));
  }

  void toggleHarvestInfoSection() {
    emit(
      state.copyWith(
        isShowingHarvestInfoSection: !state.isShowingHarvestInfoSection,
      ),
    );
  }

  void toggleCultivationAssessmentSection() {
    emit(
      state.copyWith(
        isShowingCultivationAssessmentSection:
            !state.isShowingCultivationAssessmentSection,
      ),
    );
  }

  void toggleFeedSection() {
    emit(state.copyWith(isShowingFeedSection: !state.isShowingFeedSection));
  }

  void toggleCultivationResultsSection() {
    emit(
      state.copyWith(
        isShowingCultivationResultsSection:
            !state.isShowingCultivationResultsSection,
      ),
    );
  }
}
