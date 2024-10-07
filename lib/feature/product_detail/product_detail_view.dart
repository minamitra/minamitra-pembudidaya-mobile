import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/view/checkout_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailView extends StatefulWidget {
  final ProductsResponseData data;

  const ProductDetailView(this.data, {super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  // List<String> listImage = [
  //   AppAssets.productSlide1Image,
  //   AppAssets.productSlide1Image,
  //   AppAssets.productSlide1Image,
  // ];
  // int activeIndex = 0;
  bool isHideDescription = true;

  Widget appbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.white.withOpacity(0.25),
              ),
              child: Image.asset(
                AppAssets.arrowLeftIcon,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white.withOpacity(0.25),
                ),
                child: Image.asset(
                  AppAssets.shareIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
    );
  }

  Widget imageCarousel() {
    // return CarouselSlider.builder(
    //   itemCount: listImage.length,
    //   itemBuilder: (context, index, realIndex) {
    //     return InkWell(
    //       onTap: () {},
    //       child: Image.asset(
    //         listImage[index],
    //         width: double.infinity,
    //         fit: BoxFit.cover,
    //       ),
    //     );
    //   },
    //   options: CarouselOptions(
    //     viewportFraction: 1,
    //     initialPage: 0,
    //     aspectRatio: 375 / 262,
    //     onPageChanged: (index, reason) {
    //       setState(() {
    //         activeIndex = index;
    //       });
    //     },
    //   ),
    // );
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 375 / 262,
        child: AppNetworkImage(
          widget.data.imageUrl ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Widget imageIndicator() {
  //   return Positioned(
  //     bottom: 16,
  //     child: AnimatedSmoothIndicator(
  //       activeIndex: activeIndex,
  //       count: listImage.length,
  //       effect: const ExpandingDotsEffect(
  //         dotHeight: 7,
  //         dotWidth: 7,
  //         activeDotColor: AppColor.white,
  //       ),
  //     ),
  //   );
  // }

  Widget header() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        imageCarousel(),
        // imageIndicator(),
        appbar(),
      ],
    );
  }

  Widget info() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.name ?? "-",
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12.0),
          Text(
            widget.data.sellPrice == null
                ? "-"
                : appConvertCurrency(double.parse(widget.data.sellPrice!)),
            textAlign: TextAlign.start,
            style: appTextTheme(context).headlineSmall?.copyWith(
                  color: AppColor.accent,
                ),
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColor.green[500],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    double.parse(widget.data.stock!).round() > 0
                        ? 'Stok Tersedia'
                        : 'Stok Habis',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).titleSmall?.copyWith(
                          color: double.parse(widget.data.stock!).round() > 0
                              ? AppColor.green[500]
                              : AppColor.neutral[400],
                        ),
                  ),
                ],
              ),
              // Text(
              //   widget.data.stock != null
              //       ? "${double.parse(widget.data.stock!).round().toString()} Tersedia"
              //       : "-",
              //   textAlign: TextAlign.start,
              //   style: appTextTheme(context).bodySmall?.copyWith(
              //         color: AppColor.neutral[500],
              //       ),
              // ),
            ],
          ),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 48,
          ),
          Row(
            children: [
              Image.asset(
                AppAssets.minamitraLogo,
                width: 38,
                height: 38,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16.0),
              Text(
                widget.data.supplierName ?? "-",
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget rowText(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
              ),
        ),
        Text(
          value,
          textAlign: TextAlign.start,
          style: appTextTheme(context).titleSmall!,
        ),
      ],
    );
  }

  Widget description() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi Produk',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20.0),
          rowText('Kategori', widget.data.categoryName ?? "-"),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          rowText('Satuan', widget.data.unitName ?? "-"),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          rowText(
            'Protein',
            widget.data.proteinPercent == null
                ? "-"
                : '${widget.data.proteinPercent}%',
          ),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          rowText(
            'Lemak',
            widget.data.lemakPercent == null
                ? "-"
                : '${double.parse(widget.data.lemakPercent!).round()}%',
          ),
          isHideDescription
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: AppColor.neutral[200],
                      thickness: 1,
                      height: 32,
                    ),
                    rowText(
                      'Serat Kasar',
                      widget.data.seratKasarPercent == null
                          ? "-"
                          : '${double.parse(widget.data.seratKasarPercent!).round()}%',
                    ),
                    Divider(
                      color: AppColor.neutral[200],
                      thickness: 1,
                      height: 32,
                    ),
                    rowText(
                      'Kadar Abu',
                      widget.data.kadarAbuPercent == null
                          ? "-"
                          : '${double.parse(widget.data.kadarAbuPercent!).round()}%',
                    ),
                    Divider(
                      color: AppColor.neutral[200],
                      thickness: 1,
                      height: 32,
                    ),
                    rowText(
                        'Kadar Air',
                        widget.data.kadarAirPercent == null
                            ? "-"
                            : '${double.parse(widget.data.kadarAirPercent!).round()}%'),
                    Divider(
                      color: AppColor.neutral[200],
                      thickness: 1,
                      height: 32,
                    ),
                    Text(
                      "Keterangan",
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodySmall?.copyWith(
                            color: AppColor.neutral[500],
                          ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.data.note ?? "-",
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodySmall,
                    ),
                  ],
                ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                setState(() {
                  isHideDescription = !isHideDescription;
                });
              },
              child: Text(
                isHideDescription ? "Lihat Selengkapnya" : "Sembunyikan",
                textAlign: TextAlign.center,
                style: appTextTheme(context).titleSmall?.copyWith(
                      color: AppColor.secondary[900],
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewCard(
    String imageProfile,
    String name,
    String date,
    String description,
    String point,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              imageProfile,
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall,
                ),
                Text(
                  'Dipesan pada $date',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).labelLarge!.copyWith(
                        color: AppColor.neutral[500],
                      ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: AppColor.neutral[100]!,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.starSingleIcon,
                    width: 14,
                    height: 14,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    point,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          description,
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall,
          softWrap: true,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget review() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: AppColor.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('4.8',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall!),
              const SizedBox(width: 6.0),
              Image.asset(
                AppAssets.starSingleIcon,
                width: 16,
                height: 16,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Ulasan (109)',
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall!,
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Text(
                  'Lihat Semua',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall?.copyWith(
                        color: AppColor.secondary[900],
                      ),
                ),
              ),
            ],
          ),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          reviewCard(
            AppAssets.dummyPerson1Image,
            "Darrell Steward",
            "21 Agustus 2023",
            "Figma ipsum component variant main layer. Selection plugin align hand ellipse strikethrough hand style. Library bold object invite asset.",
            "4.8",
          ),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          reviewCard(
            AppAssets.dummyPerson2Image,
            "Albert Flores",
            "20 Agustus 2023",
            "Figma ipsum component variant main layer. Selection plugin align hand ellipse strikethrough hand style. Library bold object invite asset.",
            "4.8",
          ),
        ],
      ),
    );
  }

  Widget body() {
    return ListView(
      children: [
        header(),
        info(),
        const SizedBox(height: 20.0),
        description(),
        // const SizedBox(height: 20.0),
        // review(),
        const SizedBox(height: 98.0),
      ],
    );
  }

  Widget buttonChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border(
          top: BorderSide(
            color: AppColor.neutral[200]!,
            width: 1.0,
          ),
        ),
      ),
      child: AppPrimaryFullButton(
        "Beli Sekarang",
        () {
          Navigator.of(context).push(AppTransition.pushTransition(
            CheckoutPage(widget.data),
            CheckoutPage.route,
          ));
        },
      ),
    );
  }

  List<Widget> detailOrder() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        body(),
        buttonChart(),
      ],
    );
  }
}
