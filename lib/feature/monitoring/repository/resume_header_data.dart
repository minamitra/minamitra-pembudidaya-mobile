import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';

class ResumeHeaderData {
  final String title;
  final String value;
  final String imageAsset;

  ResumeHeaderData({
    required this.title,
    required this.value,
    required this.imageAsset,
  });
}

class ResumeHeaderDataWrapped {
  final List<ResumeHeaderData> listActivtyHeaderDataDummy;

  ResumeHeaderDataWrapped({required this.listActivtyHeaderDataDummy});
}

List<ResumeHeaderData> listActivtyHeaderDataDummy1(
  String harvestResult,
  String eppValue,
) =>
    [
      ResumeHeaderData(
        title: 'Hasil Panen',
        value: harvestResult,
        imageAsset: AppAssets.overviewHppPerTailIcon,
      ),
      ResumeHeaderData(
        title: 'Nilai EPP',
        value: eppValue,
        imageAsset: AppAssets.overviewHppPerTailIcon,
      ),
    ];

List<ResumeHeaderData> listActivtyHeaderDataDummy2(
  String srValue,
  String fcrValue,
) =>
    [
      ResumeHeaderData(
        title: 'Nilai SR',
        value: srValue,
        imageAsset: AppAssets.overviewHppPerTailIcon,
      ),
      ResumeHeaderData(
        title: 'Nilai FCR',
        value: fcrValue,
        imageAsset: AppAssets.overviewHppPerTailIcon,
      ),
    ];

List<ResumeHeaderData> listActivtyHeaderDataDummy3(
  String growthValue,
  String productivityValue,
) =>
    [
      ResumeHeaderData(
        title: 'Pertumbuhan Ikan',
        value: growthValue,
        imageAsset: AppAssets.overviewHppPerTailIcon,
      ),
      ResumeHeaderData(
        title: 'Produktivitas',
        value: productivityValue,
        imageAsset: AppAssets.overviewHppPerTailIcon,
      ),
    ];

List<ResumeHeaderDataWrapped> resumeHeaderDataWrapped({
  required String harvestResult,
  required String eppValue,
  required String srValue,
  required String fcrValue,
  required String growthValue,
  required String productivityValue,
}) =>
    [
      ResumeHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy1(
          harvestResult,
          eppValue,
        ),
      ),
      ResumeHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy2(
          srValue,
          fcrValue,
        ),
      ),
      ResumeHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy3(
          growthValue,
          productivityValue,
        ),
      ),
    ];
