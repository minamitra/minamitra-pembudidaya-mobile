import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';

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
        title: 'Est. Biaya',
        value: AppCurrencyFormatter.format(
            double.tryParse(estimasiJualValue) ?? 0.0),
        imageAsset: AppAssets.sellEstimationActivityIcon,
      ),
    ];

List<ActivityHeaderDataWrapped> activityHeaderDataWrappedList({
  required double biomassaValue,
  required double srValue,
  required double pakanValue,
  required double estimasiJualValue,
}) =>
    [
      ActivityHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy1(
          appConvert3Digits(biomassaValue),
          appConvert3Digits(srValue),
        ),
      ),
      ActivityHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy2(
          appConvert3Digits(pakanValue),
          estimasiJualValue.toStringAsFixed(0),
        ),
      ),
    ];
