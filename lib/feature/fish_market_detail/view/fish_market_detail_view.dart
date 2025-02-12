import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/widget_on_progress_feature.dart';

class FishMarketDetailView extends StatefulWidget {
  const FishMarketDetailView({super.key});

  @override
  State<FishMarketDetailView> createState() => _FishMarketDetailViewState();
}

class _FishMarketDetailViewState extends State<FishMarketDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        color: AppColor.primary[800],
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: 375 / 262,
              child: InkWell(
                onTap: () {
                  showImageViewer(
                    context,
                    Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg/640px-Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg')
                        .image,
                    immersive: false,
                    useSafeArea: true,
                    swipeDismissible: true,
                    doubleTapZoomable: true,
                    backgroundColor: Colors.black.withOpacity(0.7),
                  );
                },
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg/640px-Balantiocheilos_melanopterus_-_Karlsruhe_Zoo_02_%28cropped%29.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.dummyDetailActivityBannerImage,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              left: 18.0,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8.0,
              right: 18.0,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.share_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget itemData(
      String title,
      String value,
    ) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF727C98),
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColor.black,
                ),
          ),
        ],
      );
    }

    Widget body() {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 18.0),
          Text(
            'Patin 600gr',
            textAlign: TextAlign.start,
            style: appTextTheme(context)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
          const SizedBox(height: 18.0),
          itemData(
            'Tanggal',
            '21 Sept 2024, 11:30',
          ),
          const SizedBox(height: 18.0),
          itemData(
            'Nama Pasar',
            'Pasar Oku Timur, Sumatera Selatan',
          ),
          const SizedBox(height: 18.0),
          itemData(
            'Jenis Ikan',
            'Patin',
          ),
          const SizedBox(height: 18.0),
          Row(
            children: [
              Expanded(
                child: itemData(
                  'Ukuran Ikan',
                  '800 gram',
                ),
              ),
              Expanded(
                child: itemData(
                  'Harga Satuan',
                  'Rp 120.000',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          itemData(
            'Catatan',
            'Ikan patin dengan berat 800 gram adalah ikan air tawar yang banyak dibudidayakan karena pertumbuhannya yang cepat dan harga jual yang stabil. Biasanya dipanen setelah 6-8 bulan pemeliharaan, ikan ini memiliki tubuh memanjang dan warna keperakan. Dikenal dengan kandungan protein tinggi dan rendah lemak.',
          ),
          const SizedBox(height: 18.0),
        ],
      );
    }

    return ListView(
      children: [
        header(),
        WidgetFeatureOnProgressComponent(),
        body(),
      ],
    );
  }
}
