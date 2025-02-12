import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/literacy_information_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/literacy_information/literacy_information_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'literacy_information_state.dart';

class LiteracyInformationCubit extends Cubit<LiteracyInformationState> {
  LiteracyInformationCubit(this.service)
      : super(const LiteracyInformationState());

  final LiteracyInformationService service;

  bool isLastPage = false;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      isLastPage = false;
      // Define code here to get data from API
      // dont forget to add limit and current page
      final response = await service.literacyInformations(page: '1');
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          datas: response.data.data,
          currentPage: response.data.pagination?.current,
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

  Future<void> loadMoreData() async {
    emit(state.copyWith(status: GlobalState.loadMore));
    try {
      if (!isLastPage) {
        final response = await service.literacyInformations(
          page: (state.currentPage + 1).toString(),
        );
        isLastPage =
            response.data.pagination?.totalPage == state.currentPage + 1;
        emit(
          state.copyWith(
            status: GlobalState.loaded,
            datas: (state.datas ?? []) + (response.data.data ?? []),
            currentPage: response.data.pagination?.current,
          ),
        );
      } else {
        emit(state.copyWith(status: GlobalState.loaded));
      }
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
