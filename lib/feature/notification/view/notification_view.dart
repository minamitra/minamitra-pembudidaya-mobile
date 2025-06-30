import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/logic/notification_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/repositories/notification_list_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification_detail/view/notification_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    Widget emptyNotification() {
      return const Center(
        child: AppEmptyData(
          'Belum Ada Notifikasi',
          descriptions: 'Tenang, pemberitahuan akan muncul secara real-time',
          customImage: AppAssets.emptyNotificationIcon,
          isCenter: true,
        ),
      );
    }

    Widget itemCard(
      String title,
      String date,
      String description, {
      required void Function() onTap,
      String? image,
      bool isRead = false,
    }) {
      return Container(
        color: isRead ? AppColor.white : AppColor.primary[50],
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: AppColor.primary[100],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications,
                          color: AppColor.primary,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: appTextTheme(context).titleSmall,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              date,
                              style: appTextTheme(context)
                                  .labelLarge
                                  ?.copyWith(color: AppColor.neutral[400]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    description,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .labelLarge
                        ?.copyWith(color: AppColor.neutral[500]),
                  ),
                  if (image != null) ...[
                    const SizedBox(height: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        image,
                        width: double.infinity,
                        height: 135.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    }

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 24.0),
            itemBuilder: (context, index) {
              return AppShimmer(
                180.0,
                double.infinity,
                12.0,
                margin: EdgeInsets.only(
                  top: index == 0 ? 8.0 : 0.0,
                  left: 16.0,
                  right: 16.0,
                ),
              );
            },
          );
        }

        return ListView.separated(
          separatorBuilder: (context, index) => AppDividerSmall(),
          itemCount: state.notificationListResponse?.data?.length ?? 0,
          itemBuilder: (context, index) {
            final notification = state.notificationListResponse?.data?[index];
            return itemCard(
              notification?.title ?? '-',
              AppConvertDateTime()
                  .dmyNamehhmm(notification?.createDatetime ?? DateTime.now()),
              notification?.message ?? '-',
              isRead: notification?.isReadBool ?? false,
              image: null,
              onTap: () {
                context.read<NotificationCubit>().readNotification(
                      notification ?? NotificationListResponseData(),
                    );
              },
            );
          },
        );
      },
    );
  }
}
