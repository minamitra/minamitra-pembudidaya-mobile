import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/view/checkout_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  List<String> listImage = [
    AppAssets.productSlide1Image,
    AppAssets.productSlide1Image,
    AppAssets.productSlide1Image,
  ];
  int activeIndex = 0;

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
                color: AppColor.white.withOpacity(0.2),
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
                  color: AppColor.white.withOpacity(0.2),
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
    return CarouselSlider.builder(
      itemCount: listImage.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
          onTap: () {},
          child: Image.asset(
            listImage[index],
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        initialPage: 0,
        aspectRatio: 375 / 262,
        onPageChanged: (index, reason) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
    );
  }

  Widget imageIndicator() {
    return Positioned(
      bottom: 16,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: listImage.length,
        effect: const ExpandingDotsEffect(
          dotHeight: 7,
          dotWidth: 7,
          activeDotColor: AppColor.white,
        ),
      ),
    );
  }

  Widget header() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        imageCarousel(),
        imageIndicator(),
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
            'Pakan Siap Cetak (PSC) Mina Mitra Mandiri',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12.0),
          Text(
            'Rp 190.000',
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
                    'Stok Tersedia',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).titleSmall?.copyWith(
                          color: AppColor.green[500],
                        ),
                  ),
                ],
              ),
              Text(
                '2700 Terjual',
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: AppColor.neutral[500],
                    ),
              ),
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
                'Mina Mitra Mandiri',
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
          rowText('Kategori', 'Pakan Ikan'),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          rowText('Ukuran', '1 Sak (30,00 kg)'),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          rowText('Protein', '32%'),
          Divider(
            color: AppColor.neutral[200],
            thickness: 1,
            height: 32,
          ),
          rowText('Lemak', '5%'),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              child: Text(
                "Lihat Selengkapnya",
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
        const SizedBox(height: 16.0),
        description(),
        const SizedBox(height: 16.0),
        review(),
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
        "Tambah ke Keranjang",
        () {
          Navigator.of(context).push(AppTransition.pushTransition(
            const CheckoutPage(),
            CheckoutPage.route,
          ));
        },
        prefixIcon: const Icon(
          Icons.add,
          size: 24,
          color: AppColor.white,
        ),
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
