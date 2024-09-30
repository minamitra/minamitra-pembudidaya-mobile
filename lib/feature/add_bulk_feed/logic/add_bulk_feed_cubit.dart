import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/repositories/recommendation_feed_bulk_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_bulk_feed/repositories/save_bulk_body.dart';

part 'add_bulk_feed_state.dart';

class AddBulkFeedCubit extends Cubit<AddBulkFeedState> {
  AddBulkFeedCubit(this.service) : super(const AddBulkFeedState());

  final FeedActivityService service;

  String? pondID;

  Future<void> init(String pondID) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getRecommendationFeedBulk(
        pondID,
        AppConvertDateTime().ymdDash(DateTime.now()),
      );
      this.pondID = pondID;
      log(response.data.toString());
      emit(state.copyWith(
        status: GlobalState.loaded,
        recommendationFeedBulk: response.data,
        pickedDate: DateTime.now(),
      ));
    } on AppException catch (e) {
      log(e.toString());
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

  Future<void> changeDateTime(DateTime date) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.getRecommendationFeedBulk(
        pondID ?? "",
        AppConvertDateTime().ymdDash(date),
      );
      emit(state.copyWith(
        status: GlobalState.loaded,
        recommendationFeedBulk: response.data,
        pickedDate: date,
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

  void onChangeShowingPond(
    int index,
    bool isShow,
  ) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<RecommendationFeedBulkData> data =
        state.recommendationFeedBulk!.data!;
    data[index] = data[index].copyWith(isShow: isShow);
    emit(state.copyWith(
      recommendationFeedBulk:
          state.recommendationFeedBulk!.copyWith(data: data),
      status: GlobalState.loaded,
    ));
  }

  void onChangeFeedAmount(
    int index,
    double feedAmount,
  ) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<RecommendationFeedBulkData> data =
        state.recommendationFeedBulk!.data!;
    data[index].feedValuecontroller!.text = feedAmount.toString();
    data[index] = data[index].copyWith(
      feedAmount: feedAmount,
    );
    emit(state.copyWith(
      recommendationFeedBulk:
          state.recommendationFeedBulk!.copyWith(data: data),
      status: GlobalState.loaded,
    ));
  }

  void onChangeFeedName(
    int index,
    String feedName,
  ) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    final List<RecommendationFeedBulkData> data =
        state.recommendationFeedBulk!.data!;
    data[index].fishFeedIDController!.text = feedName;
    Fishfood feed = data[index].fishfoods!.firstWhere(
          (element) => element.name == feedName,
        );
    data[index] = data[index].copyWith(
      selectedFishfood: feed,
    );
    emit(state.copyWith(
      recommendationFeedBulk:
          state.recommendationFeedBulk!.copyWith(data: data),
      status: GlobalState.loaded,
    ));
  }

  Future<void> saveFeed() async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      // Cleaning data
      log("test1");
      final List<RecommendationFeedBulkData> bulkDataCleaning = state
          .recommendationFeedBulk!.data!
          .where((element) =>
              (element.feedAmount ?? 0) > 0 || element.selectedFishfood != null)
          .toList();
      log("test2");
      for (var element in bulkDataCleaning) {
        if ((element.feedAmount ?? 0) < 1) {
          emit(state.copyWith(status: GlobalState.hideDialogLoading));
          emit(state.copyWith(
            status: GlobalState.error,
            errorMessage:
                "Jumlah pakan di kolam ${element.fishpondName} tidak boleh kurang dari 1",
          ));
          return;
        }
        if (element.selectedFishfood == null) {
          emit(state.copyWith(status: GlobalState.hideDialogLoading));
          emit(state.copyWith(
            status: GlobalState.error,
            errorMessage:
                "Silahkan pilih jenis pakan untuk ${element.fishpondName}",
          ));
          return;
        }
      }
      if (bulkDataCleaning.isEmpty) {
        emit(state.copyWith(
          status: GlobalState.error,
          errorMessage: "Tidak ada data yang disimpan",
        ));
        return;
      }
      SaveBulkBody saveBulkBody = SaveBulkBody(
        date: state.pickedDate!,
        data: bulkDataCleaning,
      );
      await service.saveFeedBulkData(saveBulkBody);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.successSubmit,
        errorMessage: "Berhasil menyimpan data",
      ));
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
