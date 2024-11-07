import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/delivery_address/delivery_address_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/repositories/member_address_response.dart';

part 'address_member_state.dart';

class AddressMemberCubit extends Cubit<AddressMemberState> {
  AddressMemberCubit(this.service) : super(const AddressMemberState());

  final DeliveryAddressService service;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getAddresses();
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          memberAddressResponse: response.data.data,
        ),
      );
    } on AppException catch (e) {
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
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
