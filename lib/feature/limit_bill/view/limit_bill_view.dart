import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/limit_bill/limit_bill/limit_bill_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class LimitBillView extends StatefulWidget {
  const LimitBillView(this.currentLimit, {super.key});

  final int currentLimit;

  @override
  State<LimitBillView> createState() => _LimitBillViewState();
}

class _LimitBillViewState extends State<LimitBillView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(
      () {
        if (scrollController.offset >
            MediaQuery.sizeOf(context).height * 0.02) {
          context.read<LimitBillCubit>().showBackgroundAppBar(true);
        } else {
          context.read<LimitBillCubit>().showBackgroundAppBar(false);
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget backgroundHeader() {
      return Container(
        height: 260.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36.0),
            bottomRight: Radius.circular(36.0),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF00317E),
              Color(0XFF002155),
            ],
          ),
        ),
      );
    }

    Widget appBar() {
      return Align(
        alignment: Alignment.topCenter,
        child: BlocBuilder<LimitBillCubit, LimitBillState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              color: state.isShowingBackgroundAppBar
                  ? AppColor.primary[800]
                  : AppColor.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: kToolbarHeight - 18.0),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColor.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 18.0),
                      Text(
                        'Informasi Limit',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context)
                            .headlineSmall
                            ?.copyWith(color: AppColor.white),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Widget currentLimitCard() {
      return Container(
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xFFE5E7EB)),
          boxShadow: AppBoxShadow().small,
        ),
        child: Row(
          children: [
            Image.asset(
              AppAssets.moneyBillIcon,
              height: 28.0,
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Limit Saat Ini',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(color: const Color(0xFF9CA3AF)),
                ),
                const SizedBox(height: 4.0),
                Text(
                  appConvertCurrency(widget.currentLimit.toDouble()),
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      );
    }

    List<Widget> informationBill() {
      return [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          margin: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: AppColor.primary[50],
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: AppColor.primary[500]!,
              width: 2.0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColor.primary[500],
                size: 24.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Dengan menjaga skor kredit, semakin besar kesempatan mendapatkan limit yang lebih tinggi',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.neutral[500],
                      ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            'Informasi Kredit Limit',
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            'Kredit limit yang diberikan Pemodalan Dompet3M kepadamu sudah disesuaikan dengan profil keuanganmu sehingga kamu dapat menggunakan kredit limitmu dengan bertanggung jawab.',
            textAlign: TextAlign.start,
            style: appTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
          ),
        ),
      ];
    }

    Widget howToIncreaseLimitItem(
      String image,
      String title,
      String desc,
    ) {
      return Row(
        children: [
          Container(
            height: 46.0,
            width: 46.0,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.primary[50],
            ),
            child: Image.asset(image),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  desc,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).labelLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF9CA3AF),
                      ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget howToIncreaseLimit() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cara Meningkatkan Limitmu',
              textAlign: TextAlign.start,
              style: appTextTheme(context)
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18.0),
            howToIncreaseLimitItem(
              AppAssets.moneyCoinBillIcon,
              'Terus Bertransaksi Dengan Dompet3M',
              'Selalu gunakan Dompet3M ketika bertransaksi',
            ),
            const SizedBox(height: 18.0),
            howToIncreaseLimitItem(
              AppAssets.notesBillIcon,
              'Selalu Bayar Tagihanmu Tepat Waktu',
              'Selalu bayar tagihanmu tepat waktu',
            ),
            const SizedBox(height: 18.0),
            howToIncreaseLimitItem(
              AppAssets.notesBillIcon,
              'Ajukan Kenaikan Limit',
              'Ajukan 3 bulan setelah 3 bulan pemakaian dan dapatkan limit hingga Rp50.000.000',
            ),
            const SizedBox(height: 18.0),
            howToIncreaseLimitItem(
              AppAssets.notesBillIcon,
              'Tujukkan Bukti Kenaikan Penghasilan',
              'Hubungkan akun bank gajimu dan informasikan penghasilanmu.',
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    Widget body() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        children: [
          const SizedBox(height: kToolbarHeight + 18.0),
          Center(
            child: ShakeY(
              delay: const Duration(milliseconds: 0),
              duration: const Duration(milliseconds: 2600),
              infinite: true,
              from: 6.0,
              curve: Curves.linear,
              child: Image.asset(
                AppAssets.flyMoneyBillImage,
                height: 220.0,
              ),
            ),
          ),
          Container(
            color: AppColor.white,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                currentLimitCard(),
                const SizedBox(height: 12.0),
                ...informationBill(),
                const SizedBox(height: 18.0),
                const AppDivider(
                  color: Color(0xFFEFF0F7),
                  thickness: 12.0,
                ),
                const SizedBox(height: 18.0),
                howToIncreaseLimit(),
              ],
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        backgroundHeader(),
        body(),
        appBar(),
      ],
    );
  }
}
