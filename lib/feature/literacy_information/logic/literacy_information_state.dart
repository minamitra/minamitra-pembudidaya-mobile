part of 'literacy_information_cubit.dart';

class LiteracyInformationState extends Equatable {
  const LiteracyInformationState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.currentPage = 1,
    this.datas = const [],
  });

  final GlobalState status;
  final String errorMessage;
  final int currentPage;
  final List<LiteracyInformationResponseData>? datas;

  LiteracyInformationState copyWith({
    GlobalState? status,
    String? errorMessage,
    int? currentPage,
    List<LiteracyInformationResponseData>? datas,
  }) {
    return LiteracyInformationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      datas: datas ?? this.datas,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        currentPage,
        datas ?? [],
      ];
}
