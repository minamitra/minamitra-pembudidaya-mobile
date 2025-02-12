import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/bill_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/authentication/authentication_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/bill/bill_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/plafon_distribution/plafon_distribution_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_balance_response.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this.authService,
    this.billService,
    this.plafonDistributionService,
    this.pointService,
  ) : super(const ProfileState());

  final AuthenticationService authService;
  final BillService billService;
  final PlafonDistributionService plafonDistributionService;
  final PointService pointService;

  int totalSumCostNominalOther = 0;
  double percentageOther = 0.0;

  Future<void> init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      totalSumCostNominalOther = 0;
      percentageOther = 0.0;
      final billSummary = await billService.billSummary();
      final plafonSummary = await plafonDistributionService.plafonSummary();
      final pointBalance = await pointService.pointBalance();
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
      emit(
        state.copyWith(
          status: GlobalState.loaded,
          billSummaryResponse: billSummary.data,
          plafonSummaryResponse: plafonSummary.data,
          plafonDistributionResponse: plafonDistribution.data,
          pointBalance: pointBalance.data,
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

  Future<void> logout() async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await authService.logout();
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
