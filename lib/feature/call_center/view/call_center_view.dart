import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CallCenterView extends StatefulWidget {
  const CallCenterView({super.key});

  @override
  State<CallCenterView> createState() => _CallCenterViewState();
}

class _CallCenterViewState extends State<CallCenterView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> header() {
      return [
        Text(
          "Hubungi Kami",
          style: appTextTheme(context)
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12.0),
        Text(
          "Jika Anda memiliki pertanyaan atau membutuhkan bantuan lebih lanjut mengenai aplikasi Mitra3M, Anda dapat menghubungi kami di:",
          style: appTextTheme(context)
              .bodySmall
              ?.copyWith(color: AppColor.neutral[500]),
        )
      ];
    }

    Widget callCenterItem(
      IconData icon,
      String text,
      Function() onTap,
    ) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 16.0,
          ),
          decoration: BoxDecoration(
            color: AppColor.neutral[50],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColor.primary[500],
              ),
              const SizedBox(width: 18.0),
              Text(
                text,
                style: appTextTheme(context)
                    .titleMedium
                    ?.copyWith(color: AppColor.primary[900]),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> callCenterActionItems() {
      return [
        callCenterItem(
          Icons.phone_in_talk_rounded,
          "0812-3456-789",
          () {},
        ),
        const SizedBox(height: 18.0),
        callCenterItem(
          Icons.mail_rounded,
          "mitra.3m@gmail.com",
          () {},
        ),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          const SizedBox(height: 18.0),
          ...header(),
          const SizedBox(height: 36.0),
          ...callCenterActionItems(),
          const Spacer(),
          AppPrimaryFullButton(
            "Hubungi Admin",
            () {},
            prefixIcon: const Icon(
              Icons.chat_rounded,
              color: AppColor.white,
            ),
          ),
          const SizedBox(height: 18.0),
        ],
      ),
    );
  }
}
