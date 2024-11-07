import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
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

    return ListView.separated(
      separatorBuilder: (context, index) => AppDividerSmall(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return itemCard(
          'Pemberitahuan Penting',
          '12 Agustus 2021',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          isRead: index % 2 == 0,
          image: index & 2 == 0 ? AppAssets.dummyNotificationImage : null,
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                NotificationDetailPage(
                  'Pemberitahuan Penting',
                  '12 Agustus 2021',
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  image:
                      index & 2 == 0 ? AppAssets.dummyNotificationImage : null,
                ),
                NotificationDetailPage.routeSettings(),
              ),
            );
          },
        );
      },
    );
  }
}
