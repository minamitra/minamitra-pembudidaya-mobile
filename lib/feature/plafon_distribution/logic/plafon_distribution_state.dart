part of 'plafon_distribution_cubit.dart';

class PlafonDistributionState extends Equatable {
  const PlafonDistributionState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.showingShowMore = true,
  });

  final GlobalState status;
  final String errorMessage;
  final bool showingShowMore;

  PlafonDistributionState copyWith({
    GlobalState? status,
    String? errorMessage,
    bool? showingShowMore,
  }) {
    return PlafonDistributionState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      showingShowMore: showingShowMore ?? this.showingShowMore,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        showingShowMore,
      ];
}
