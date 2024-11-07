part of 'address_member_cubit.dart';

class AddressMemberState extends Equatable {
  const AddressMemberState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.memberAddressResponse = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final List<MemberAddressResponseData>? memberAddressResponse;

  AddressMemberState copyWith({
    GlobalState? status,
    String? errorMessage,
    List<MemberAddressResponseData>? memberAddressResponse,
  }) {
    return AddressMemberState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      memberAddressResponse:
          memberAddressResponse ?? this.memberAddressResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        memberAddressResponse ?? [],
      ];
}
