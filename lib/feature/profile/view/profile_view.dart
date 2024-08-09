import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    Widget headerProfile() {
      return Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(AppAssets.profileImageDummy),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 18.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mina Mitra Mandiri",
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                "No KTA 003 | 081125699",
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: AppColor.neutral[400],
                    ),
              ),
            ],
          ),
        ],
      );
    }

    Widget pointCard() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColor.primary,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  Container(
                    height: 38.0,
                    width: 38.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.neutral[100],
                      image: const DecorationImage(
                        image: AssetImage(AppAssets.startFullIcon),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "10 Poin",
                        style: appTextTheme(context).headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Bronze",
                        style: appTextTheme(context).labelLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  SizedBox(
                    width: 98.0,
                    child: AppWhiteButton(
                      "Tukar Poin",
                      () {},
                      height: 32.0,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                AppAssets.circleBackdropImage,
                height: 78.0,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      );
    }

    Widget actionMenu(
      String title,
      String descriptions, {
      required Function() onTap,
      bool isRedTitle = false,
    }) {
      return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: appTextTheme(context).bodySmall?.copyWith(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: isRedTitle ? Colors.red : null,
                              ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          descriptions,
                          style: appTextTheme(context).bodySmall?.copyWith(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: AppColor.neutral[400],
                              ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.primary[900],
                  )
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            Divider(
              color: AppColor.neutral[100],
              thickness: 1.0,
              height: 0.0,
            ),
          ],
        ),
      );
    }

    List<Widget> actionMenuList() {
      return [
        actionMenu(
          "Informasi Pribadi",
          "Informasi akun milikmu",
          onTap: () {},
        ),
        actionMenu(
          "Pengaturan Rekening",
          "Alamat rekening untuk penarikan saldo",
          onTap: () {},
        ),
        actionMenu(
          "Tentang Kami",
          "Informasi mengenai Mitra3M",
          onTap: () {},
        ),
        actionMenu(
          "FAQ",
          "Informasi mengenai Mitra3M",
          onTap: () {},
        ),
        actionMenu(
          "Hubungi Pusat Bantuan",
          "Hubungi untuk informasi lebih lanjut",
          onTap: () {},
        ),
        actionMenu(
          "Keluar",
          "Keluar dari akun kamu",
          onTap: () {},
          isRedTitle: true,
        ),
      ];
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        headerProfile(),
        const SizedBox(height: 18.0),
        pointCard(),
        const SizedBox(height: 18.0),
        ...actionMenuList(),
      ],
    );
  }
}
