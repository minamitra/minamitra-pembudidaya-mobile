import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ReferralView extends StatefulWidget {
  const ReferralView({super.key});

  @override
  State<ReferralView> createState() => _ReferralViewState();
}

class _ReferralViewState extends State<ReferralView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> header() {
      return [
        Image.asset(
          AppAssets.referralIllustrationImage,
          height: 375.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 18.0),
        Text(
          "Undang teman dapat koin",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Untuk setiap teman yang bergabung melalui undangan, kamu mendapatkan 10 koin",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: AppColor.neutral[500]),
        ),
        const SizedBox(height: 36.0),
        Text(
          "Kode Unik Kamu",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 18.0),
        DottedBorder(
          color: AppColor.primary[500]!,
          radius: const Radius.circular(8.0),
          borderType: BorderType.RRect,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 12.0,
            ),
            color: const Color(0xffF8FAFC),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "ABC1234",
                    style: appTextTheme(context)
                        .titleMedium
                        ?.copyWith(color: AppColor.primary[900]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(const ClipboardData(text: "ABC1234"))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Referral berhasil disalin")));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary[600],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "Salin",
                      style: appTextTheme(context).titleSmall?.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18.0),
      ];
    }

    Widget guideItem({
      required String index,
      required String value,
    }) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.black),
            ),
            child: Text(
              index,
              style: appTextTheme(context).bodySmall,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(
                value,
                style: appTextTheme(context).bodySmall,
              ),
            ),
          ),
        ],
      );
    }

    List<Widget> guide() {
      return [
        const SizedBox(height: 18.0),
        Text(
          "Bagaimana Cara Kerjanya?",
          style: appTextTheme(context).titleMedium,
        ),
        const SizedBox(height: 18.0),
        guideItem(
          index: "1",
          value: "Salin kode unik dan bagikan ke temanmu",
        ),
        const SizedBox(height: 18.0),
        guideItem(
          index: "2",
          value: "Temanmu membuat akun baru berdasarkan kode referall",
        ),
        const SizedBox(height: 18.0),
        guideItem(
          index: "3",
          value: "Saldo 10 koin akan masuk ke koinmu",
        ),
        const SizedBox(height: 18.0),
      ];
    }

    Widget statisticItem({
      required String iconAsset,
      required String title,
      required String value,
    }) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColor.neutralBlueGrey[50],
        ),
        child: Row(
          children: [
            Image.asset(
              iconAsset,
              height: 24.0,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                title,
                style: appTextTheme(context).titleSmall,
              ),
            ),
            const SizedBox(width: 12.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: AppColor.primary[600],
              ),
              child: Text(
                value,
                style: appTextTheme(context)
                    .labelLarge
                    ?.copyWith(color: AppColor.white),
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> statistic() {
      return [
        const SizedBox(height: 18.0),
        Text(
          "Statistik",
          style: appTextTheme(context).titleMedium,
        ),
        const SizedBox(height: 18.0),
        statisticItem(
          iconAsset: AppAssets.userInvitedIcon,
          title: "Teman diundang",
          value: "50",
        ),
        const SizedBox(height: 18.0),
        statisticItem(
          iconAsset: AppAssets.pointRewardedIcon,
          title: "Point didapat",
          value: "200",
        ),
        const SizedBox(height: 18.0),
      ];
    }

    Widget shareButton() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: AppPrimaryFullButton(
          "Bagikan",
          () {},
          prefixIcon: Icon(
            Icons.share_outlined,
            color: Colors.white,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            children: [
              ...header(),
              ...guide(),
              ...statistic(),
            ],
          ),
        ),
        shareButton(),
      ],
    );
  }
}
