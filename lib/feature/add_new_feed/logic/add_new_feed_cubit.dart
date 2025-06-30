import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/suplier_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/unit_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities_add/repositories/feer_recomendation_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_new_feed/repositories/add_new_feed_body.dart';

part 'add_new_feed_state.dart';

class AddNewFeedCubit extends Cubit<AddNewFeedState> {
  AddNewFeedCubit(
    this.service,
    this.publicService,
  ) : super(const AddNewFeedState());

  final FeedActivityService service;
  final PublicService publicService;

  final TextEditingController newFeedTypeController = TextEditingController();
  final TextEditingController newFeedNameController = TextEditingController();
  final TextEditingController newFeedSizeController = TextEditingController();
  final TextEditingController newFeedProteinController =
      TextEditingController();
  final TextEditingController newFeedEPPController = TextEditingController();
  final TextEditingController newFeedPriceController = TextEditingController();
  final TextEditingController newFeedUnitController = TextEditingController();
  final TextEditingController newFeedSupplierController =
      TextEditingController();
  final TextEditingController newFeedNoteController = TextEditingController();

  int fishpondId = 0;
  int unitId = 0;
  int supplierId = 0;

  Future<void> init(
    int fishpondId,
    FeedRecomendationResponse feedRecomendationResponse,
  ) async {
    this.fishpondId = fishpondId;
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final unitResponse = await publicService.unitResponse();
      final supplierResponse = await publicService.supplierResponse();
      setNewFeedType(
        (feedRecomendationResponse.data?.fishfoods?.first.type ?? 'finisher')
            .replaceAll(' ', ''),
      );
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          unitList: unitResponse.data.data,
          supplierList: supplierResponse.data.data,
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

  void setNewFeedType(String value) {
    newFeedTypeController.text = value;
  }

  void setNewFeedUnit(String value) {
    newFeedUnitController.text = value;
    unitId = int.tryParse(
          state.unitList.firstWhere((element) => element.name == value).id ??
              '0',
        ) ??
        0;
  }

  void setNewFeedSupplier(String value) {
    newFeedSupplierController.text = value;
    supplierId = int.tryParse(
          state.supplierList
                  .firstWhere((element) => element.name == value)
                  .id ??
              '0',
        ) ??
        0;
  }

  Future<void> process() async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      newFeedPriceController.text = AppCurrencyFormatter()
          .unFormatedCurrency(newFeedPriceController.text);
      final AddNewFeedBody body = AddNewFeedBody(
        fishpondId: fishpondId,
        type: newFeedTypeController.text,
        name: newFeedNameController.text,
        weight: double.tryParse(newFeedSizeController.text),
        proteinPercent: int.tryParse(newFeedProteinController.text),
        eppEstimationPercent: int.tryParse(newFeedEPPController.text),
        price: int.tryParse(newFeedPriceController.text),
        unitId: unitId,
        supplierId: supplierId,
        note: newFeedNoteController.text,
      );
      await service.addNewFeed(body);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
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
