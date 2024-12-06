part of 'resume_cubit.dart';

class ResumeState extends Equatable {
  const ResumeState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.resumeSummary,
    this.resumePerCycle = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final ResumeSummaryResponseData? resumeSummary;
  final List<ResumePerCycleResponseData> resumePerCycle;

  ResumeState copyWith({
    GlobalState? status,
    String? errorMessage,
    ResumeSummaryResponseData? resumeSummary,
    List<ResumePerCycleResponseData>? resumePerCycle,
  }) {
    return ResumeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      resumeSummary: resumeSummary ?? this.resumeSummary,
      resumePerCycle: resumePerCycle ?? this.resumePerCycle,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        resumeSummary ?? ResumeSummaryResponseData(),
        resumePerCycle,
      ];
}
