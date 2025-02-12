import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/meta_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/plafon_distribution/plafon_distribution_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_another_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_feed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_seed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_treatment_use_response.dart';

part 'plafon_distribution_state.dart';

class PlafonDistributionCubit extends Cubit<PlafonDistributionState> {
  PlafonDistributionCubit(
    this.plafonDistributionService,
  ) : super(const PlafonDistributionState());

  final PlafonDistributionService plafonDistributionService;

  int totalSumCostNominalOther = 0;
  double percentageOther = 0.0;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      totalSumCostNominalOther = 0;
      percentageOther = 0.0;
      String fishpondName = '';
      BaseResponse<PlafonDistributionSummaryResponse>? plafonUseSummary;
      BaseResponse<DetailFeedUseResponse>? plafonFeedUse;
      BaseResponse<DetailTreatmentUseResponse>? plafonTreatmentUse;
      BaseResponse<DetailSeedUseResponse>? plafonSeedUse;
      BaseResponse<DetailAnotherUseResponse>? plafonAnotherUse;

      final plafonSummary = await plafonDistributionService.plafonSummary();
      final plafonDistribution =
          await plafonDistributionService.plafonDistribution();
      if ((plafonDistribution.data.data?.length ?? 0) > 3) {
        for (int i = 2; i < plafonDistribution.data.data!.length - 1; i++) {
          totalSumCostNominalOther +=
              plafonDistribution.data.data![i].sumCostNominal ?? 0;
        }
        for (int i = 2; i < plafonDistribution.data.data!.length - 1; i++) {
          percentageOther += plafonDistribution.data.data![i].percentage ?? 0;
        }
      }
      if (plafonDistribution.data.data?.isNotEmpty ?? false) {
        fishpondName = plafonDistribution.data.data![0].name ?? '';
        plafonUseSummary = await plafonDistributionService
            .detailSummaryUse(plafonDistribution.data.data![0].id ?? '');
        plafonFeedUse = await plafonDistributionService
            .detailFeedUse(plafonDistribution.data.data![0].id ?? '');
        plafonTreatmentUse = await plafonDistributionService
            .detailTreatmentUse(plafonDistribution.data.data![0].id ?? '');
        plafonSeedUse = await plafonDistributionService
            .detailSeedUse(plafonDistribution.data.data![0].id ?? '');
        plafonAnotherUse = await plafonDistributionService
            .detailAnotherUse(plafonDistribution.data.data![0].id ?? '');
      }

      emit(
        state.copyWith(
          status: GlobalState.loaded,
          plafonSummaryResponse: plafonSummary.data,
          plafonDistributionResponse: plafonDistribution.data,
          plafonUseSummaryResponse: plafonUseSummary?.data,
          plafonFeedUseResponse: plafonFeedUse,
          plafonTreatmentUseResponse: plafonTreatmentUse,
          plafonSeedUseResponse: plafonSeedUse,
          plafonAnotherUseResponse: plafonAnotherUse,
          selectedPond: fishpondName,
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
      log(e.toString());
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> onChangeDetailUse(String changeName) async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      String id = state.plafonDistributionResponse?.data
              ?.firstWhere((element) => (element.name ?? '') == changeName)
              .id ??
          '';
      BaseResponse<PlafonDistributionSummaryResponse>? plafonUseSummary;
      BaseResponse<DetailFeedUseResponse>? plafonFeedUse;
      BaseResponse<DetailTreatmentUseResponse>? plafonTreatmentUse;
      BaseResponse<DetailSeedUseResponse>? plafonSeedUse;
      BaseResponse<DetailAnotherUseResponse>? plafonAnotherUse;
      plafonUseSummary = await plafonDistributionService.detailSummaryUse(id);
      plafonFeedUse = await plafonDistributionService.detailFeedUse(id);
      plafonTreatmentUse =
          await plafonDistributionService.detailTreatmentUse(id);
      plafonSeedUse = await plafonDistributionService.detailSeedUse(id);
      plafonAnotherUse = await plafonDistributionService.detailAnotherUse(id);
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          plafonUseSummaryResponse: plafonUseSummary.data,
          plafonFeedUseResponse: plafonFeedUse,
          plafonTreatmentUseResponse: plafonTreatmentUse,
          plafonSeedUseResponse: plafonSeedUse,
          plafonAnotherUseResponse: plafonAnotherUse,
          selectedPond: changeName,
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
      log(e.toString());
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void changeShowMore(bool isShowingShowMore) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        showingShowMore: isShowingShowMore,
      ),
    );
  }
}
