part of 'call_center_cubit.dart';

class CallCenterState extends Equatable {
  const CallCenterState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.waNumber,
    this.email,
    this.location,
  });

  final GlobalState status;
  final String errorMessage;
  final PublicResponse? waNumber;
  final PublicResponse? email;
  final PublicResponse? location;

  CallCenterState copyWith({
    GlobalState? status,
    String? errorMessage,
    PublicResponse? waNumber,
    PublicResponse? email,
    PublicResponse? location,
  }) {
    return CallCenterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      waNumber: waNumber ?? this.waNumber,
      email: email ?? this.email,
      location: location ?? this.location,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        waNumber ?? '',
        email ?? '',
        location ?? '',
      ];
}
