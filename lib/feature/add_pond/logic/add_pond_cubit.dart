import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/add_pond_cycle_payload.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/add_pond_payload.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/repositories/update_pond_payload.dart';
part 'add_pond_state.dart';

class AddPondCubit extends Cubit<AddPondState> {
  AddPondCubit(
    this.refService,
    this.pondService,
  ) : super(const AddPondState());

  final RefService refService;
  final PondService pondService;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      emit(state.copyWith(
        status: GlobalState.loaded,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void changeStep(int index) {
    emit(state.copyWith(status: GlobalState.loading));
    emit(state.copyWith(
      index: index,
      status: GlobalState.refresh,
    ));
  }

  Future<void> addPond({
    required AddPondPayload pondPayload,
    required AddPondCyclePayload pondCyclePayload,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final addPondResponse = await pondService.addPond(pondPayload);
      pondCyclePayload.fishpondId = addPondResponse.data.data?.fishpondId;
      await pondService.addPondCycle(pondCyclePayload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addNewCycle({
    required String pondID,
    required AddPondCyclePayload pondCyclePayload,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      pondCyclePayload.fishpondId = int.parse(pondID);
      await pondService.addPondCycle(pondCyclePayload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void setUpdatePond(UpdatePondPayload pondPayload) {
    emit(state.copyWith(
      updatePondPayload: pondPayload,
    ));
  }

  Future<void> updatePond({
    required UpdatePondPayload pondPayload,
  }) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      UpdatePondPayload finalPayload = UpdatePondPayload(
        id: state.updatePondPayload?.id,
        name: state.updatePondPayload?.name,
        areaLength: state.updatePondPayload?.areaLength,
        areaWidth: state.updatePondPayload?.areaWidth,
        areaDepth: state.updatePondPayload?.areaDepth,
        addressProvinceId: pondPayload.addressProvinceId,
        addressProvinceName: pondPayload.addressProvinceName,
        addressCityId: pondPayload.addressCityId,
        addressCityName: pondPayload.addressCityName,
        addressSubdistrictId: pondPayload.addressSubdistrictId,
        addressSubdistrictName: pondPayload.addressSubdistrictName,
        addressVillageId: pondPayload.addressVillageId,
        addressVillageName: pondPayload.addressVillageName,
        address: pondPayload.address,
        addressLongitude: pondPayload.addressLongitude,
        addressLatitude: pondPayload.addressLatitude,
        imageUrl: pondPayload.imageUrl,
      );
      await pondService.updatePond(finalPayload);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
