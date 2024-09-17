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

final List<ActivityHeaderDataDummy> listActivtyHeaderDataDummy1 = [
  ActivityHeaderDataDummy(
    title: 'Biomasa',
    value: '100 Kg',
    imageAsset: AppAssets.biomassaActivityIcon,
  ),
  ActivityHeaderDataDummy(
    title: 'Est. Survival Rate',
    value: '50 %',
    imageAsset: AppAssets.survivalRateActivtyIcon,
  ),
];

final List<ActivityHeaderDataDummy> listActivtyHeaderDataDummy2 = [
  ActivityHeaderDataDummy(
    title: 'Pakan',
    value: '15.2 Kg',
    imageAsset: AppAssets.feedActivityIcon,
  ),
  ActivityHeaderDataDummy(
    title: 'Estimasi Jual',
    value: 'Rp 15 Juta',
    imageAsset: AppAssets.sellEstimationActivityIcon,
  ),
];

final List<ActivityHeaderDataWrapped> activityHeaderDataWrappedList = [
  ActivityHeaderDataWrapped(
      listActivtyHeaderDataDummy: listActivtyHeaderDataDummy1),
  ActivityHeaderDataWrapped(
      listActivtyHeaderDataDummy: listActivtyHeaderDataDummy2),
];
