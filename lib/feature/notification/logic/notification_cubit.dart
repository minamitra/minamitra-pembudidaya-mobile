import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_key.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/notification/notification_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/repositories/notification_list_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification_detail/view/notification_detail_page.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(
    this.context,
    this.notificationService,
  ) : super(const NotificationState());

  final BuildContext context;
  final NotificationService notificationService;
  final SharedPreferenceService sharedPreferenceService =
      SharedPreferenceServiceImpl.create();

  Future<void> getNotificationList() async {
    emit(state.copyWith(status: GlobalState.loading));
    try {
      final response = await notificationService.notificationList();
      sharedPreferenceService.setSharedPreference(
        AppSharedPrefKey.isHasNotificationKey,
        'false',
      );
      emit(
        state.copyWith(
          notificationListResponse: response.data,
          status: GlobalState.loaded,
        ),
      );
    } on AppException catch (e) {
      log('getNotificationList catch: ${e.message}');
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      log('getNotificationList catch: $e');
      emit(
        state.copyWith(
          status: GlobalState.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> readNotification(
    NotificationListResponseData notification,
  ) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      final data =
          await notificationService.readNotification(notification.id ?? '');
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      await Future.delayed(
        const Duration(milliseconds: 350),
        () {
          if (context.mounted) {
            Navigator.of(context)
                .push(
              AppTransition.pushTransition(
                NotificationDetailPage(
                  data.data.title ?? '',
                  AppConvertDateTime().dmyNamehhmm(
                    data.data.createDatetime ?? DateTime.now(),
                  ),
                  data.data.message ?? '',
                  image: null,
                ),
                NotificationDetailPage.routeSettings(),
              ),
            )
                .then((value) async {
              await getNotificationList();
            });
          }
        },
      );
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.message,
        ),
      );
      await Future.delayed(
        const Duration(milliseconds: 350),
        () {
          if (context.mounted) {
            Navigator.of(context)
                .push(
              AppTransition.pushTransition(
                NotificationDetailPage(
                  notification.title ?? '',
                  AppConvertDateTime().dmyNamehhmm(
                    notification.createDatetime ?? DateTime.now(),
                  ),
                  notification.message ?? '',
                  image: null,
                ),
                NotificationDetailPage.routeSettings(),
              ),
            )
                .then((value) async {
              await getNotificationList();
            });
          }
        },
      );
    } catch (e) {
      log('readNotification catch: $e');
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(
        state.copyWith(
          status: GlobalState.error,
          errorMessage: e.toString(),
        ),
      );
      await Future.delayed(
        const Duration(milliseconds: 350),
        () {
          if (context.mounted) {
            Navigator.of(context)
                .push(
              AppTransition.pushTransition(
                NotificationDetailPage(
                  notification.title ?? '',
                  AppConvertDateTime().dmyNamehhmm(
                    notification.createDatetime ?? DateTime.now(),
                  ),
                  notification.message ?? '',
                  image: null,
                ),
                NotificationDetailPage.routeSettings(),
              ),
            )
                .then((value) async {
              await getNotificationList();
            });
          }
        },
      );
    }
  }
}
