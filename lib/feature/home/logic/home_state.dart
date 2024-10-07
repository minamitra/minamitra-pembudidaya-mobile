part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.bannerResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final HomeResponse? bannerResponse;

  HomeState copyWith({
    GlobalState? status,
    String? errorMessage,
    HomeResponse? bannerResponse,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      bannerResponse: bannerResponse,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        bannerResponse,
      ];
}
