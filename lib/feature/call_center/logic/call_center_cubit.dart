import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/public_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'call_center_state.dart';

class CallCenterCubit extends Cubit<CallCenterState> {
  CallCenterCubit(this.service) : super(const CallCenterState());

  final PublicService service;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final waNumber = await service.waNumber();
      final email = await service.email();
      final location = await service.officeLocation();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          waNumber: waNumber.data,
          email: email.data,
          location: location.data,
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
