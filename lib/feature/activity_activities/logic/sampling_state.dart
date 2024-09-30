part of 'sampling_cubit.dart';

class SamplingState extends Equatable {
  const SamplingState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.samplings,
  });

  final GlobalState status;
  final String errorMessage;
  final List<SamplingResponseData>? samplings;

  SamplingState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<SamplingResponseData>? samplings,
  }) {
    return SamplingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      samplings: samplings ?? this.samplings,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        samplings,
      ];
}
