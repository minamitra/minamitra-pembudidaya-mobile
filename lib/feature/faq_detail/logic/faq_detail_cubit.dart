import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq/repositories/faq_list_response.dart';

part 'faq_detail_state.dart';

class FaqDetailCubit extends Cubit<FaqDetailState> {
  FaqDetailCubit(this.service) : super(const FaqDetailState());

  final PublicService service;

  Future<void> init(String id) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.faqDetail(id);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          faqDetailData: response.data,
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
