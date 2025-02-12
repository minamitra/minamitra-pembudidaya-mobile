import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/literacy_information_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/balance/balance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/home/home_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/literacy_information/literacy_information_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/profile/profile_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/home_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/repositories/point_configuration_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this.service,
    this.balanceService,
    this.literacyInformationService,
    this.pointService,
  ) : super(const HomeState());

  final HomeService service;
  final BalanceService balanceService;
  final LiteracyInformationService literacyInformationService;
  final PointService pointService;

  void init() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await service.homeBanner();
      final billSummary = await balanceService.balance();
      final literacyInformationResponse =
          await literacyInformationService.literacyInformations(
        page: '1',
        limit: '4',
      );
      final pointBalance = await pointService.pointBalance();
      final pointConfiguration = await pointService.pointConfiguration();

      emit(
        state.copyWith(
          status: GlobalState.loaded,
          bannerResponse: response.data,
          balanceResponse: billSummary.data,
          literacyInformationResponse: literacyInformationResponse.data,
          pointBalance: pointBalance.data,
          pointConfigruation: pointConfiguration.data,
        ),
      );
      emit(state.copyWith(status: GlobalState.onUpdating));
      await Future.delayed(const Duration(milliseconds: 50));
      emit(state.copyWith(status: GlobalState.loaded));
    } on AppException catch (e) {
      log(e.message.toString());
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
