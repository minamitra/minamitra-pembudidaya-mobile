part of 'privacy_policy_cubit.dart';

class PrivacyPolicyState extends Equatable {
  const PrivacyPolicyState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.privacyPolicy,
  });

  final GlobalState status;
  final String errorMessage;
  final PrivacyPolicyResponseData? privacyPolicy;

  PrivacyPolicyState copyWith({
    GlobalState? status,
    String? errorMessage,
    PrivacyPolicyResponseData? privacyPolicy,
  }) {
    return PrivacyPolicyState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        privacyPolicy,
      ];
}
