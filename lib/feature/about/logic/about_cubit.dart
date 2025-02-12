import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/public_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit(this.service) : super(const AboutState());

  final PublicService service;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.aboutUs();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          aboutUsResponse: response.data,
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
