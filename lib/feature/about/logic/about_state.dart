part of 'about_cubit.dart';

class AboutState extends Equatable {
  const AboutState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.aboutUsResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final PublicResponse? aboutUsResponse;

  AboutState copyWith({
    GlobalState? status,
    String? errorMessage,
    PublicResponse? aboutUsResponse,
  }) {
    return AboutState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      aboutUsResponse: aboutUsResponse ?? this.aboutUsResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        aboutUsResponse ?? '',
      ];
}
