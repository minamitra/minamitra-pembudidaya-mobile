part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.bannerResponse,
    this.balanceResponse,
    this.literacyInformationResponse,
    this.pointBalance,
    this.pointConfigruation,
  });

  final GlobalState status;
  final String errorMessage;
  final HomeResponse? bannerResponse;
  final BalanceResponse? balanceResponse;
  final LiteracyInformationResponse? literacyInformationResponse;
  final PointBalanceResponse? pointBalance;
  final PointConfigurationResponse? pointConfigruation;

  HomeState copyWith({
    GlobalState? status,
    String? errorMessage,
    HomeResponse? bannerResponse,
    BalanceResponse? balanceResponse,
    LiteracyInformationResponse? literacyInformationResponse,
    PointBalanceResponse? pointBalance,
    PointConfigurationResponse? pointConfigruation,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bannerResponse: bannerResponse ?? this.bannerResponse,
      balanceResponse: balanceResponse ?? this.balanceResponse,
      literacyInformationResponse:
          literacyInformationResponse ?? this.literacyInformationResponse,
      pointBalance: pointBalance ?? this.pointBalance,
      pointConfigruation: pointConfigruation ?? this.pointConfigruation,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        bannerResponse,
        balanceResponse,
        literacyInformationResponse,
        pointBalance,
        pointConfigruation,
      ];
}
