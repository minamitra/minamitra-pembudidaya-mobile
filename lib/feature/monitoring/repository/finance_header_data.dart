import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';

class FinanceHeaderData {
  final String title;
  final String value;
  final String imageAsset;

  FinanceHeaderData({
    required this.title,
    required this.value,
    required this.imageAsset,
  });
}

class ActivityHeaderDataWrapped {
  final List<FinanceHeaderData> listActivtyHeaderDataDummy;

  ActivityHeaderDataWrapped({required this.listActivtyHeaderDataDummy});
}

List<FinanceHeaderData> listActivtyHeaderDataDummy1(
  String totalProductionCost,
  String totalRevenue,
) =>
    [
      FinanceHeaderData(
        title: 'Total biaya produksi',
        value: totalProductionCost,
        imageAsset: AppAssets.overviewProductionCostIcon,
      ),
      FinanceHeaderData(
        title: 'Total pendapatan',
        value: totalRevenue,
        imageAsset: AppAssets.overviewRevenueIcon,
      ),
    ];

List<FinanceHeaderData> listActivtyHeaderDataDummy2(
  String hppPerHead,
  String totalProfitLoss,
) =>
    [
      FinanceHeaderData(
        title: 'HPP Per ekor',
        value: hppPerHead,
        imageAsset: AppAssets.overviewHppPerTailIcon,
      ),
      FinanceHeaderData(
        title: 'Total laba/rugi',
        value: totalProfitLoss,
        imageAsset: AppAssets.overviewTotalProfitLossIcon,
      ),
    ];

List<FinanceHeaderData> listActivtyHeaderDataDummy3(
  String hppPerKg,
  String totalProfitLossPercentage,
) =>
    [
      FinanceHeaderData(
        title: 'HPP Per kilogram',
        value: hppPerKg,
        imageAsset: AppAssets.biomassaActivityIcon,
      ),
      FinanceHeaderData(
        title: 'Total laba/rugi (%)',
        value: totalProfitLossPercentage,
        imageAsset: AppAssets.overviewTotalProfitLossPercentageIcon,
      ),
    ];

List<ActivityHeaderDataWrapped> financeHeaderDataWrapped({
  required double totalProductionCost,
  required double totalRevenue,
  required double hppPerHead,
  required double totalProfitLoss,
  required double hppPerKg,
  required double totalProfitLossPercentage,
}) =>
    [
      ActivityHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy1(
          appConvertCurrency(totalProductionCost),
          appConvertCurrency(totalRevenue),
        ),
      ),
      ActivityHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy2(
          appConvertCurrency(hppPerHead),
          appConvertCurrency(totalProfitLoss),
        ),
      ),
      ActivityHeaderDataWrapped(
        listActivtyHeaderDataDummy: listActivtyHeaderDataDummy3(
          appConvertCurrency(hppPerKg),
          '$totalProfitLossPercentage %',
        ),
      ),
    ];
