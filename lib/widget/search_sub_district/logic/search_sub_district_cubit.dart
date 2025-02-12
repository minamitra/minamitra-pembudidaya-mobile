import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/sub_district_response.dart';

part 'search_sub_district_state.dart';

class SearchSubDistrictCubit extends Cubit<SearchSubDistrictState> {
  SearchSubDistrictCubit(this.refService)
      : super(const SearchSubDistrictState());

  final RefService refService;

  Future<void> searchSubDistrict(String keyword) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final result = await refService.subDistrict(
        null,
        search: keyword,
      );
      emit(
        state.copyWith(
          subDistrictResponse: result.data,
          status: GlobalState.loaded,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
