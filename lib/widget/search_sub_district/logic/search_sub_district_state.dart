part of 'search_sub_district_cubit.dart';

class SearchSubDistrictState extends Equatable {
  const SearchSubDistrictState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.subDistrictResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final SubDistrictResponse? subDistrictResponse;

  SearchSubDistrictState copyWith({
    GlobalState? status,
    String? errorMessage,
    SubDistrictResponse? subDistrictResponse,
  }) {
    return SearchSubDistrictState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      subDistrictResponse: subDistrictResponse ?? this.subDistrictResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        subDistrictResponse ?? SubDistrictResponse(),
      ];
}
