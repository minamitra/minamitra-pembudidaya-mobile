import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/user/user_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/view/address_member_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/profile_member_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    Widget headerProfile() {
      return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
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
                    state.userData?.name ?? "-",
                    style: appTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "No KTA - | ${state.userData?.mobilephone ?? "-"}",
                    style: appTextTheme(context).bodySmall?.copyWith(
                          color: AppColor.neutral[400],
                        ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    Widget balanceLegendItem(
      Color color,
      String pond,
      String balance,
    ) {
      return Row(
        children: [
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              pond,
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: AppColor.neutral[400],
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Text(
            balance,
            style: appTextTheme(context)
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    Widget currentlyUsedBalance() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColor.white,
          boxShadow: AppBoxShadow().medium,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pengeluaran",
              style: appTextTheme(context).titleSmall,
            ),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Rp 1.000.000",
                  style: appTextTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  "dari Rp 1.500.000",
                  style: appTextTheme(context).labelLarge?.copyWith(
                        color: AppColor.neutral[400],
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 12.0,
              width: double.infinity,
              child: Stack(
                children: [
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    animation: true,
                    lineHeight: 12.0,
                    animationDuration: 1000,
                    percent: 0.65,
                    barRadius: const Radius.circular(8.0),
                    progressColor: AppColor.green[500],
                    backgroundColor: AppColor.neutral[100],
                  ),
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    animation: true,
                    lineHeight: 12.0,
                    animationDuration: 1000,
                    percent: 0.49,
                    barRadius: const Radius.circular(8.0),
                    progressColor: AppColor.accent[900],
                    backgroundColor: Colors.transparent,
                  ),
                  LinearPercentIndicator(
                    padding: const EdgeInsets.all(0),
                    animation: true,
                    lineHeight: 12.0,
                    animationDuration: 1000,
                    percent: 0.33,
                    barRadius: const Radius.circular(8.0),
                    progressColor: AppColor.primary[500],
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
            balanceLegendItem(
              AppColor.primary[500]!,
              "Kolam 1",
              "Rp 500.000",
            ),
            const SizedBox(height: 8.0),
            balanceLegendItem(
              AppColor.accent[900]!,
              "Kolam 2",
              "Rp 250.000",
            ),
            const SizedBox(height: 8.0),
            balanceLegendItem(
              AppColor.green[500]!,
              "Kolam 3",
              "Rp 250.000",
            ),
          ],
        ),
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
          onTap: () {
            Navigator.of(context).push(AppTransition.pushTransition(
              const ProfileMemberPage(),
              ProfileMemberPage.routeSettings,
            ));
          },
        ),
        actionMenu(
          "Alamat Saya",
          "Daftar alamat saya",
          onTap: () {
            Navigator.of(context).push(AppTransition.pushTransition(
              const AddressMemberPage(),
              AddressMemberPage.routeSettings,
            ));
          },
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
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return AppDefaultDialog(
                  title: "Keluar",
                  subTitle: "Yakin ingin keluar?",
                  buttons: [
                    Row(
                      children: [
                        Expanded(
                          child: AppWhiteButton(
                            "Batal",
                            () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: AppPrimaryButton(
                            "Keluar",
                            () {
                              RepositoryProvider.of<AuthenticationRepository>(
                                      context)
                                  .logout();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
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
        currentlyUsedBalance(),
        const SizedBox(height: 18.0),
        pointCard(),
        const SizedBox(height: 18.0),
        ...actionMenuList(),
      ],
    );
  }
}
