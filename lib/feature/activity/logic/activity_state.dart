part of 'activity_cubit.dart';

class ActivityState extends Equatable {
  const ActivityState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.pondReponse,
    this.currentPage,
  });

  final GlobalState status;
  final String errorMessage;
  final List<PondResponseData>? pondReponse;
  final int? currentPage;

  ActivityState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<PondResponseData>? pondReponse,
    int? currentPage,
  }) {
    return ActivityState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      pondReponse: pondReponse ?? this.pondReponse,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        pondReponse,
        currentPage,
      ];
}
