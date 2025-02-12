part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.billSummaryResponse,
    this.plafonSummaryResponse,
    this.plafonDistributionResponse,
    this.pointBalance,
  });

  final GlobalState status;
  final String errorMessage;
  final BillSummaryResponse? billSummaryResponse;
  final PlafonSummaryResponse? plafonSummaryResponse;
  final PlafonDistributionResponse? plafonDistributionResponse;
  final PointBalanceResponse? pointBalance;

  ProfileState copyWith({
    GlobalState? status,
    String? errorMessage,
    BillSummaryResponse? billSummaryResponse,
    PlafonSummaryResponse? plafonSummaryResponse,
    PlafonDistributionResponse? plafonDistributionResponse,
    PointBalanceResponse? pointBalance,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      billSummaryResponse: billSummaryResponse ?? this.billSummaryResponse,
      plafonSummaryResponse:
          plafonSummaryResponse ?? this.plafonSummaryResponse,
      plafonDistributionResponse:
          plafonDistributionResponse ?? this.plafonDistributionResponse,
      pointBalance: pointBalance ?? this.pointBalance,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        billSummaryResponse ?? '',
        plafonSummaryResponse ?? '',
        plafonDistributionResponse ?? '',
        pointBalance ?? '',
      ];
}
