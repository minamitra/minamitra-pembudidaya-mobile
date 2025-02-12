import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_refresher.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/dashboard/dashboard_bottom_nav_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/user/user_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/about/view/about_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/view/activity_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/view/address_member_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment/view/bill_payment_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/call_center/view/call_center_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/change_password/view/change_password_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/logic/dashboard_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq/views/faq_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/view/plafon_distribution_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/view/point_v2_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/privacy_policy/views/privacy_policy_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile/logic/profile_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/profile_member_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/referral/view/referral_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/term_condition/views/term_condition_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/bottom_sheet/showing_register_member_bottom_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget headerProfile() {
      return BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return state.status.isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      AppShimmer(
                        60.0,
                        60.0,
                        1000.0,
                      ),
                      SizedBox(width: 18.0),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmer(
                            12.0,
                            60.0,
                            18.0,
                          ),
                          SizedBox(height: 4),
                          AppShimmer(
                            12.0,
                            120.0,
                            18.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: (state.userData?.imageUrl != null &&
                                state.userData?.imageUrl != '')
                            ? AppNetworkImage(
                                state.userData!.imageUrl!,
                                width: 60.0,
                                height: 60.0,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppAssets.profileImageDummy,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 18.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.userData?.name ?? '-',
                            style: appTextTheme(context).titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, profileState) {
                              String generateIcon(String name) {
                                switch (name) {
                                  case 'Bronze':
                                    return AppAssets.bronzeV2Icon;
                                  case 'Silver':
                                    return AppAssets.silverV2Icon;
                                  case 'Gold':
                                    return AppAssets.goldV2Icon;
                                  case 'Platinum':
                                    return AppAssets.platinumV2Icon;
                                  case 'Diamond':
                                    return AppAssets.diamondV2Icon;
                                  default:
                                    return AppAssets.bronzeV2Icon;
                                }
                              }

                              if (profileState.status.isLoading) {
                                return const AppShimmer(
                                  12.0,
                                  120.0,
                                  18.0,
                                );
                              }

                              if (state.userData?.type?.toLowerCase() !=
                                  'member') {
                                return Text(
                                  state.userData?.type?.toLowerCase() ==
                                          'farmer'
                                      ? 'Pembudidaya'
                                      : 'Pengguna',
                                  style:
                                      appTextTheme(context).bodySmall?.copyWith(
                                            color: AppColor.neutral[400],
                                          ),
                                );
                              }

                              if ((state.userData?.isSubmission() ?? false) ||
                                  (state.userData?.isProcessed() ?? false) ||
                                  (state.userData?.isRejected() ?? false)) {
                                return Text(
                                  state.userData?.type?.toLowerCase() ==
                                          'farmer'
                                      ? 'Pembudidaya'
                                      : 'Pengguna',
                                  style:
                                      appTextTheme(context).bodySmall?.copyWith(
                                            color: AppColor.neutral[400],
                                          ),
                                );
                              }

                              return Row(
                                children: [
                                  Image.asset(
                                    generateIcon(
                                      profileState.pointBalance?.data?.levelName
                                              .handlingEmptyString() ??
                                          '-',
                                    ),
                                    height: 14.0,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    '${profileState.pointBalance?.data?.levelName.handlingEmptyString() ?? '-'} Member',
                                    style: appTextTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColor.neutral[400],
                                        ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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

    List<Widget> linierIndicator(List<PlafonDistributionResponseData> data) {
      log(data.length.toString());
      if (data.length > 3) {
        return [
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 12.0,
            animationDuration: 1000,
            percent: ((data[0].percentage ?? 0) +
                    (data[1].percentage ?? 0) +
                    context.read<ProfileCubit>().percentageOther) /
                100,
            barRadius: const Radius.circular(8.0),
            progressColor: AppColor.green[500],
            backgroundColor: AppColor.neutral[100],
          ),
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 12.0,
            animationDuration: 1000,
            percent:
                ((data[0].percentage ?? 0) + (data[1].percentage ?? 0)) / 100,
            barRadius: const Radius.circular(8.0),
            progressColor: AppColor.accent[900],
            backgroundColor: Colors.transparent,
          ),
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 12.0,
            animationDuration: 1000,
            percent: (data[0].percentage ?? 0) / 100,
            barRadius: const Radius.circular(8.0),
            progressColor: AppColor.primary[500],
            backgroundColor: Colors.transparent,
          ),
        ];
      } else {
        List<Widget> dataWidget = [];
        for (int index = data.length - 1; index >= 0; index--) {
          dataWidget = [
            ...dataWidget,
            LinearPercentIndicator(
              padding: const EdgeInsets.all(0),
              animation: true,
              lineHeight: 12.0,
              animationDuration: 1000,
              percent: index == 0
                  ? (data[0].percentage ?? 0) / 100
                  : index == 1
                      ? ((data[0].percentage ?? 0) / 100) +
                          ((data[1].percentage ?? 0) / 100)
                      : (((data[0].percentage ?? 0) / 100) +
                              ((data[1].percentage ?? 0) / 100) +
                              ((data[2].percentage ?? 0) / 100)) /
                          100,
              barRadius: const Radius.circular(8.0),
              progressColor: index == 0
                  ? AppColor.primary[500]
                  : index == 1
                      ? AppColor.accent[900]
                      : AppColor.green[500],
              backgroundColor: index == data.length - 1
                  ? AppColor.neutral[100]
                  : Colors.transparent,
            ),
          ];
        }
        return dataWidget;
      }
    }

    List<Widget> indicatorLegend(List<PlafonDistributionResponseData> data) {
      if (data.length > 3) {
        return [
          balanceLegendItem(
            AppColor.primary[500]!,
            data[0].name ?? '-',
            appConvertCurrency((data[0].sumCostNominal ?? 0).toDouble()),
          ),
          const SizedBox(height: 8.0),
          balanceLegendItem(
            AppColor.accent[900]!,
            data[1].name ?? '-',
            appConvertCurrency((data[1].sumCostNominal ?? 0).toDouble()),
          ),
          const SizedBox(height: 8.0),
          balanceLegendItem(
            AppColor.green[500]!,
            'Lainnya',
            appConvertCurrency(
              context.read<ProfileCubit>().totalSumCostNominalOther.toDouble(),
            ),
          ),
        ];
      } else {
        List<Widget> dataWidget = [];
        for (int index = 0; index < data.length; index++) {
          dataWidget.add(
            balanceLegendItem(
              index == 0
                  ? AppColor.primary[500]!
                  : index == 1
                      ? AppColor.accent[900]!
                      : AppColor.green[500]!,
              data[index].name ?? '-',
              appConvertCurrency((data[index].sumCostNominal ?? 0).toDouble()),
            ),
          );
          dataWidget.add(const SizedBox(height: 8.0));
        }
        return dataWidget;
      }
    }

    Widget currentlyUsedBalance() {
      return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const AppShimmer(
              250.0,
              double.infinity,
              16.0,
              margin: EdgeInsets.symmetric(horizontal: 18.0),
            );
          }

          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              if ((userState.userData?.isSubmission() ?? false) ||
                  (userState.userData?.isProcessed() ?? false) ||
                  (userState.userData?.isRejected() ?? false) ||
                  userState.userData?.type?.toLowerCase() != 'member') {
                return const SizedBox();
              }

              return AppAnimatedSizeShimmer(
                isShow: state.status.isLoaded,
                height: 250.0,
                width: double.infinity,
                rounded: 16.0,
                margin: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  margin: const EdgeInsets.symmetric(horizontal: 18.0),
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
                        'Distribusi Biaya Produksi',
                        style: appTextTheme(context).titleSmall,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            appConvertCurrency(
                              (userState.userData?.type?.toLowerCase() !=
                                          'member'
                                      ? 0
                                      : state.plafonSummaryResponse?.data
                                              ?.totalCost ??
                                          0)
                                  .toDouble(),
                            ),
                            style: appTextTheme(context).bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'dari ${appConvertCurrency(
                              (userState.userData?.type?.toLowerCase() !=
                                          'member'
                                      ? 0
                                      : state.plafonSummaryResponse?.data
                                              ?.totalPlafon ??
                                          0)
                                  .toDouble(),
                            )}',
                            style: appTextTheme(context).labelLarge?.copyWith(
                                  color: AppColor.neutral[400],
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      if (userState.userData?.type?.toLowerCase() != 'member')
                        SizedBox(
                          height: 12.0,
                          width: double.infinity,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            animation: true,
                            lineHeight: 12.0,
                            animationDuration: 1000,
                            percent: 0,
                            barRadius: const Radius.circular(8.0),
                            progressColor: AppColor.green[500],
                            backgroundColor: AppColor.neutral[100],
                          ),
                        ),
                      if (userState.userData?.type?.toLowerCase() == 'member')
                        SizedBox(
                          height: 12.0,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              ...linierIndicator(
                                state.plafonDistributionResponse?.data ?? [],
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 18.0),
                      if (userState.userData?.type?.toLowerCase() == 'member')
                        ...indicatorLegend(
                          state.plafonDistributionResponse?.data ?? [],
                        ),
                      if (userState.userData?.type?.toLowerCase() != 'member')
                        Text(
                          'Segera daftarkan diri anda menjadi anggota untuk mengakses fitur distribusi biaya produksi',
                          style: appTextTheme(context).labelLarge?.copyWith(
                                color: AppColor.neutral[400],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      if (userState.userData?.type?.toLowerCase() == 'member')
                        const SizedBox(height: 18.0),
                      if (userState.userData?.type?.toLowerCase() == 'member')
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              AppTransition.pushTransition(
                                const PlafonDistributionPage(),
                                PlafonDistributionPage.routeSettings,
                              ),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Lihat Selengkapnya',
                              textAlign: TextAlign.center,
                              style: appTextTheme(context)
                                  .titleSmall
                                  ?.copyWith(color: AppColor.secondary[900]),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }

    Widget billCard() {
      return BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              return AppAnimatedSizeShimmer(
                isShow: state.status.isLoaded,
                height: 75.0,
                width: double.infinity,
                rounded: 16.0,
                margin: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColor.primary,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          AppAssets.circleBackdropImage,
                          height: 78.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 16.0,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appConvertCurrency(
                                    (userState.userData?.type?.toLowerCase() !=
                                                    'member' ||
                                                (userState.userData
                                                        ?.isSubmission() ??
                                                    false) ||
                                                (userState.userData
                                                        ?.isProcessed() ??
                                                    false) ||
                                                (userState.userData
                                                        ?.isRejected() ??
                                                    false)
                                            ? 0
                                            : state.billSummaryResponse?.data
                                                    ?.totalInvoice ??
                                                0)
                                        .toDouble(),
                                  ),
                                  style: appTextTheme(context)
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  userState.userData?.type?.toLowerCase() ==
                                          'user'
                                      ? 'Lengkapi data kolam sekarang !'
                                      : userState.userData?.type
                                                  ?.toLowerCase() ==
                                              'farmer'
                                          ? 'Daftar anggota untuk dapatkan plafon'
                                          : (userState.userData
                                                          ?.isSubmission() ??
                                                      false) ||
                                                  (userState.userData
                                                          ?.isProcessed() ??
                                                      false)
                                              ? 'Data anda dalam proses verifikasi'
                                              : (userState.userData
                                                          ?.isRejected() ??
                                                      false)
                                                  ? 'Verifikasi data anda ditolak'
                                                  : 'Total Tagihan Perlu Dibayar',
                                  style: appTextTheme(context)
                                      .labelLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            SizedBox(
                              width: 98.0,
                              child: AppWhiteButton(
                                userState.userData?.type?.toLowerCase() ==
                                        'user'
                                    ? 'Lengkapi'
                                    : userState.userData?.type?.toLowerCase() ==
                                            'farmer'
                                        ? 'Daftar'
                                        : (userState.userData?.isSubmission() ??
                                                    false) ||
                                                (userState.userData
                                                        ?.isProcessed() ??
                                                    false)
                                            ? 'Dalam proses'
                                            : (userState.userData
                                                        ?.isRejected() ??
                                                    false)
                                                ? 'Ditolak'
                                                : 'Bayar',
                                () {
                                  if (userState.userData?.type?.toLowerCase() ==
                                      'user') {
                                    context
                                        .read<DashboardBottomNavCubit>()
                                        .changeIndex(2);
                                    return;
                                  }

                                  if (userState.userData?.type?.toLowerCase() ==
                                      'farmer') {
                                    showingRegisterMemberBottomSheet(context)
                                        .then(
                                      (value) {
                                        if (value == 'cek-profile') {
                                          Navigator.of(context).push(
                                            AppTransition.pushTransition(
                                              const ProfileMemberPage(),
                                              ProfileMemberPage.routeSettings,
                                            ),
                                          );
                                        }

                                        if (value == 'register') {
                                          context
                                              .read<DashboardCubit>()
                                              .requestMember(context);
                                        }
                                      },
                                    );
                                    return;
                                  }

                                  if ((userState.userData?.isSubmission() ??
                                          false) ||
                                      (userState.userData?.isProcessed() ??
                                          false) ||
                                      (userState.userData?.isRejected() ??
                                          false)) {
                                    return;
                                  }

                                  Navigator.of(context).push(
                                    AppTransition.pushTransition(
                                      const BillPaymentPage(),
                                      BillPaymentPage.routeSettings,
                                    ),
                                  );
                                },
                                height: 32.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
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
                  ),
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
          'Informasi Pribadi',
          'Informasi akun milikmu',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const ProfileMemberPage(),
                ProfileMemberPage.routeSettings,
              ),
            );
          },
        ),
        actionMenu(
          'Alamat Saya',
          'Daftar alamat saya',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const AddressMemberPage(),
                AddressMemberPage.routeSettings,
              ),
            );
          },
        ),
        actionMenu(
          'Ganti Password',
          'Update password akunmu',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const ChangePasswordPage(),
                ChangePasswordPage.routeSettings(),
              ),
            );
          },
        ),
        const SizedBox(height: 18.0),
        const AppDivider(),
        const SizedBox(height: 18.0),
        actionMenu(
          'Pengaturan Rekening',
          'Alamat rekening untuk penarikan saldo',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const CommingSoonPage('Pengaturan Rekening'),
                CommingSoonPage.route(),
              ),
            );
          },
        ),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return actionMenu(
              'Informasi Point',
              'Informasi Poin milikmu',
              onTap: () {
                if (state.userData?.type?.toLowerCase() != 'member') {
                  AppTopSnackBar(context).showInfo(
                    'Silahkan daftar menjadi anggota\nuntuk mengakses fitur ini',
                  );
                  return;
                }
                Navigator.of(context)
                    .push(
                  AppTransition.pushTransition(
                    const PointV2Page(),
                    PointV2Page.route(),
                  ),
                )
                    .then(
                  (value) {
                    if (value == ActivityPage.routeSettings().name) {
                      context.read<DashboardBottomNavCubit>().changeIndex(2);
                    }
                  },
                );
              },
            );
          },
        ),
        const SizedBox(height: 18.0),
        const AppDivider(),
        const SizedBox(height: 18.0),
        actionMenu(
          'Tentang Kami',
          'Informasi mengenai Mitra3M',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const AboutPage(),
                AboutPage.routeSettings,
              ),
            );
          },
        ),
        actionMenu(
          'FAQ',
          'Informasi mengenai Mitra3M',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const FaqPage(),
                FaqPage.routeSettings(),
              ),
            );
          },
        ),
        actionMenu(
          'Hubungi Pusat Bantuan',
          'Hubungi untuk informasi lebih lanjut',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const CallCenterPage(),
                CallCenterPage.routeSettings,
              ),
            );
          },
        ),
        actionMenu(
          'Syarat dan Ketentuan',
          'Informasi mengenai Syarat dan Ketentuan',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const TermConditionPage(),
                TermConditionPage.routeSettings,
              ),
            );
          },
        ),
        actionMenu(
          'Kebijakan Privasi',
          'Informasi mengenai Kebijakan Privasi',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const PrivacyPolicyPage(),
                PrivacyPolicyPage.routeSettings,
              ),
            );
          },
        ),
        const SizedBox(height: 18.0),
        const AppDivider(),
        const SizedBox(height: 18.0),
        actionMenu(
          'Undang Teman',
          'Dapatkan hadiah poin',
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const ReferralPage(),
                ReferralPage.routeSettings,
              ),
            );
          },
        ),
        actionMenu(
          'Keluar',
          'Keluar dari akun kamu',
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return AppDefaultDialog(
                  title: 'Keluar',
                  subTitle: 'Yakin ingin keluar?',
                  buttons: [
                    Expanded(
                      child: AppWhiteButton(
                        'Batal',
                        () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: AppPrimaryButton(
                        'Keluar',
                        () {
                          context.read<ProfileCubit>().logout();
                        },
                      ),
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

    return AppRefresher(
      onRefresh: () {
        context.read<UserCubit>().refreshUser();
      },
      child: ListView(
        children: [
          const SizedBox(height: 18.0),
          headerProfile(),
          const SizedBox(height: 18.0),
          billCard(),
          const SizedBox(height: 18.0),
          currentlyUsedBalance(),
          const SizedBox(height: 18.0),
          ...actionMenuList(),
        ],
      ),
    );
  }
}
