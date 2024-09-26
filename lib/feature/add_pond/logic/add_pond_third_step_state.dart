part of 'add_pond_third_step_cubit.dart';

class AddPondThirdStepState extends Equatable {
  const AddPondThirdStepState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.feedStarterData,
    this.feedGrowerData,
    this.feedFinisherData,
  });

  final GlobalState status;
  final String errorMessage;
  final FeedStarterResponse? feedStarterData;
  final FeedGrowerResponse? feedGrowerData;
  final FeedFinisherResponse? feedFinisherData;

  AddPondThirdStepState copyWith({
    GlobalState? status,
    String? errorMessage,
    FeedStarterResponse? feedStarterData,
    FeedGrowerResponse? feedGrowerData,
    FeedFinisherResponse? feedFinisherData,
  }) {
    return AddPondThirdStepState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      feedStarterData: feedStarterData ?? this.feedStarterData,
      feedGrowerData: feedGrowerData ?? this.feedGrowerData,
      feedFinisherData: feedFinisherData ?? this.feedFinisherData,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        feedStarterData,
        feedGrowerData,
        feedFinisherData,
      ];
}
