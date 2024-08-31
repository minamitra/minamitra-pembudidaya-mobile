part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
  });

  final GlobalState status;
  final String errorMessage;

  HomeState copyWith({
    GlobalState? status,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
      ];
}
