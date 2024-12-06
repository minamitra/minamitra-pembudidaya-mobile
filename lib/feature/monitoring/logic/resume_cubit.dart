import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/resume/resume_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_per_cycle_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/resume_summary_response.dart';

part 'resume_state.dart';

class ResumeCubit extends Cubit<ResumeState> {
  ResumeCubit(this.service) : super(const ResumeState());

  final ResumeService service;
  String fishPondID = '0';

  Future<void> init(String fishPondID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      this.fishPondID = fishPondID;
      final resumeSummaryResponse =
          await service.summary(fishPondID: fishPondID);
      final resumePerCycleResponse =
          await service.resumePerCycle(fishPondID: fishPondID);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          resumeSummary: resumeSummaryResponse.data.data,
          resumePerCycle: resumePerCycleResponse.data.data,
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
}
