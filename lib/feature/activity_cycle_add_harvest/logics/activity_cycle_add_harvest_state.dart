part of 'activity_cycle_add_harvest_cubit.dart';

class ActivityCycleAddHarvestState extends Equatable {
  const ActivityCycleAddHarvestState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.buyerData = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<BuyerData> buyerData;

  ActivityCycleAddHarvestState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<BuyerData>? buyerData,
  }) {
    return ActivityCycleAddHarvestState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      buyerData: buyerData ?? this.buyerData,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        buyerData,
      ];
}
