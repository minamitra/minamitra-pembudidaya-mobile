import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/feature/score_credit_bill_info/logic/score_credit_bill_info_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ScoreCreditBillInfoView extends StatefulWidget {
  const ScoreCreditBillInfoView(this.score, {super.key});

  final String score;

  @override
  State<ScoreCreditBillInfoView> createState() =>
      _ScoreCreditBillInfoViewState();
}

class _ScoreCreditBillInfoViewState extends State<ScoreCreditBillInfoView> {
  final ScrollController scrollController = ScrollController();
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(milliseconds: 2500));
    _controllerCenter.play();
    scrollController.addListener(
      () {
        if (scrollController.offset >
            MediaQuery.sizeOf(context).height * 0.02) {
          context.read<ScoreCreditBillInfoCubit>().showBackgroundAppBar(true);
        } else {
          context.read<ScoreCreditBillInfoCubit>().showBackgroundAppBar(false);
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
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
        child: BlocBuilder<ScoreCreditBillInfoCubit, ScoreCreditBillInfoState>(
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
                        'Skor Kredit',
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

    Widget infoCard() {
      return Container(
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
      );
    }

    Widget howToIncreaseCreditItem(
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

    Widget howIncreaseCredit() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cara Meningkatkan Kredit Skor',
              textAlign: TextAlign.start,
              style: appTextTheme(context)
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18.0),
            howToIncreaseCreditItem(
              AppAssets.moneyCoinBillIcon,
              'Terus Bertransaksi Dengan Dompet3M',
              'Selalu gunakan Dompet3M ketika bertransaksi',
            ),
            const SizedBox(height: 18.0),
            howToIncreaseCreditItem(
              AppAssets.notesBillIcon,
              'Selalu Bayar Tagihanmu Tepat Waktu',
              'Selalu bayar tagihanmu tepat waktu',
            ),
          ],
        ),
      );
    }

    Widget body() {
      String generateScoreIcon() {
        switch (widget.score.toLowerCase()) {
          case 'a':
            return AppAssets.scoreABillIcon;
          case 'b':
            return AppAssets.scoreBBillIcon;
          case 'c':
            return AppAssets.scoreCBillIcon;
          default:
            return AppAssets.scoreCBillIcon;
        }
      }

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
              child: Image.asset(
                generateScoreIcon(),
                height: 180.0,
              ),
            ),
          ),
          const SizedBox(height: 18.0),
          Container(
            color: AppColor.white,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                infoCard(),
                const SizedBox(height: 18.0),
                howIncreaseCredit(),
                const SizedBox(height: 18.0),
                const AppDivider(
                  color: Color(0xFFEFF0F7),
                  thickness: 12.0,
                ),
                const SizedBox(height: 18.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    'Informasi Tentang Skor Kredit',
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
                    'Kredit skor menunjukkan seberapa baik kamu mengelola utang. Skor tinggi mempermudah pinjaman dengan syarat lebih baik. Skor dipengaruhi oleh pembayaran tepat waktu dan frekuensi transaksi di Dompet3M. Jaga skormu untuk pinjaman lebih mudah dan suku bunga lebih rendah!',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget star() {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight + 118.0),
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ], // manually specify the colors to be used
            createParticlePath: drawStar, // define a custom shape/path.
          ),
        ),
      );
    }

    return Stack(
      children: [
        backgroundHeader(),
        body(),
        star(),
        appBar(),
      ],
    );
  }
}
