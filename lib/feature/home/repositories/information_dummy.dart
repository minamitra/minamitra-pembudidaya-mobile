import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

class InformationDummy {
  final String imageAsset;
  final String title;
  final String description;

  InformationDummy({
    required this.imageAsset,
    required this.title,
    required this.description,
  });
}

final List<InformationDummy> informationDummyList = [
  InformationDummy(
    imageAsset: AppAssets.informationDummy2Image,
    title: "Panduan Memilih Benih Ikan Patin Berkualitas",
    description:
        "Memilih benih ikan patin yang baik akan berdampak langsung pada pertumbuhan ikan. Artikel ini memberikan tips tentang ciri-ciri benih yang sehat dan bagaimana cara pembeliannya.",
  ),
  InformationDummy(
    imageAsset: AppAssets.informationDummy3Image,
    title: "Penggunaan Pakan Starter yang Tepat untuk Ikan Patin",
    description:
        "Pada tahap awal budidaya, pakan starter memainkan peran penting. Kami akan membahas jenis pakan starter yang direkomendasikan dan cara memberikannya pada benih ikan patin.",
  ),
  InformationDummy(
    imageAsset: AppAssets.informationDummy4Image,
    title: "Mengenal Sistem Bioflok dalam Budidaya Ikan Patin",
    description:
        "Bioflok adalah sistem yang efektif untuk meningkatkan produksi ikan dengan mengoptimalkan ruang dan kualitas air. Pelajari cara kerja dan manfaat sistem bioflok dalam budidaya ikan patin.",
  )
];
