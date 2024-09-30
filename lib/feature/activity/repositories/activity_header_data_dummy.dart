import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

class ActivityHeaderDataDummy {
  final String title;
  final String value;
  final String imageAsset;

  ActivityHeaderDataDummy({
    required this.title,
    required this.value,
    required this.imageAsset,
  });
}

class ActivityHeaderDataWrapped {
  final List<ActivityHeaderDataDummy> listActivtyHeaderDataDummy;

  ActivityHeaderDataWrapped({required this.listActivtyHeaderDataDummy});
}

List<ActivityHeaderDataDummy> listActivtyHeaderDataDummy1(
  String biomassaValue,
  String srValue,
) =>
    [
      ActivityHeaderDataDummy(
        title: 'Est. Biomasa',
        value: '$biomassaValue Kg',
        imageAsset: AppAssets.biomassaActivityIcon,
      ),
      ActivityHeaderDataDummy(
        title: 'Est. Survival Rate',
        value: '$srValue %',
        imageAsset: AppAssets.survivalRateActivtyIcon,
      ),
    ];

List<ActivityHeaderDataDummy> listActivtyHeaderDataDummy2(
  String pakanValue,
  String estimasiJualValue,
) =>
    [
      ActivityHeaderDataDummy(
        title: 'Est. Pakan',
        value: '$pakanValue Kg',
        imageAsset: AppAssets.feedActivityIcon,
      ),
      ActivityHeaderDataDummy(
        title: 'Est. Jual',
        value: 'Rp $estimasiJualValue Juta',
        imageAsset: AppAssets.sellEstimationActivityIcon,
      ),
    ];

List<ActivityHeaderDataWrapped> activityHeaderDataWrappedList({
  required String biomassaValue,
  required String srValue,
  required String pakanValue,
  required String estimasiJualValue,
}) =>
    [
      ActivityHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy1(
          biomassaValue,
          srValue,
        ),
      ),
      ActivityHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy2(
          pakanValue,
          estimasiJualValue,
        ),
      ),
    ];
