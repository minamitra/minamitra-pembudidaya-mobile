import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/plafon_distribution_summary_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_another_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_feed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_seed_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/repositories/detail_treatment_use_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionBillDetailView extends StatefulWidget {
  const TransactionBillDetailView({
    super.key,
    this.plafonUseSummary,
    this.plafonFeedUse,
    this.plafonTreatmentUse,
    this.plafonSeedUse,
    this.plafonAnotherUse,
  });

  final PlafonDistributionSummaryResponse? plafonUseSummary;
  final DetailFeedUseResponse? plafonFeedUse;
  final DetailTreatmentUseResponse? plafonTreatmentUse;
  final DetailSeedUseResponse? plafonSeedUse;
  final DetailAnotherUseResponse? plafonAnotherUse;

  @override
  State<TransactionBillDetailView> createState() =>
      _TransactionBillDetailViewState();
}

class _TransactionBillDetailViewState extends State<TransactionBillDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget summaryItem(
      String title,
      String percentage,
      String value,
    ) {
      return Row(
        children: [
          Text(
            title,
            style: appTextTheme(context).bodySmall,
          ),
          const SizedBox(width: 4.0),
          Text(
            percentage,
            style: appTextTheme(context).labelLarge?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          const Spacer(),
          Text(
            value,
            style: appTextTheme(context).titleSmall,
          ),
        ],
      );
    }

    Widget summarySection() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: AppColor.neutral[50],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColor.neutral[200]!),
        ),
        child: Column(
          children: [
            summaryItem(
              'Pakan',
              '${widget.plafonUseSummary?.data!.feedingCost?.percentage} %',
              appConvertCurrency(
                (widget.plafonUseSummary?.data!.feedingCost?.costNominal ?? 0.0)
                    .toDouble(),
              ),
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              'Perlakuan',
              '${widget.plafonUseSummary?.data!.treatmentCost?.percentage} %',
              appConvertCurrency(
                (widget.plafonUseSummary?.data!.treatmentCost?.costNominal ??
                        0.0)
                    .toDouble(),
              ),
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              'Bibit/Benih',
              '${widget.plafonUseSummary?.data!.seedCost?.percentage} %',
              appConvertCurrency(
                (widget.plafonUseSummary?.data!.seedCost?.costNominal ?? 0.0)
                    .toDouble(),
              ),
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              'Lainnya',
              '${widget.plafonUseSummary?.data!.otherCost?.percentage} %',
              appConvertCurrency(
                (widget.plafonUseSummary?.data!.otherCost?.costNominal ?? 0.0)
                    .toDouble(),
              ),
            ),
          ],
        ),
      );
    }

    Widget feedTabItem(
      String title,
      String time,
      String value,
    ) {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: appTextTheme(context).titleSmall,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      time,
                      style: appTextTheme(context)
                          .bodySmall
                          ?.copyWith(color: AppColor.neutral[400]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 18.0),
              Text(
                '- Rp 100.000',
                style: appTextTheme(context)
                    .titleSmall
                    ?.copyWith(color: AppColor.accent[900]),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          AppDividerSmall(),
        ],
      );
    }

    Widget historyData() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: AppColor.neutral[50]),
              child: TabBar(
                controller: _tabController,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColor.primary,
                indicatorWeight: 2.5,
                padding: EdgeInsets.zero,
                labelColor: AppColor.primary,
                unselectedLabelColor: AppColor.neutral[400],
                labelStyle:
                    appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
                unselectedLabelStyle:
                    appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
                labelPadding: const EdgeInsets.symmetric(horizontal: 18.0),
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Pakan'),
                  Tab(text: 'Perlakuan'),
                  Tab(text: 'Bibit/Benih'),
                  Tab(text: 'Lainnya'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: widget.plafonFeedUse?.data?.isEmpty ?? true
                        ? const AppEmptyData(
                            'Tidak ada data',
                            isCenter: true,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: widget.plafonFeedUse?.data?.length,
                            itemBuilder: (context, index) {
                              return feedTabItem(
                                widget.plafonFeedUse?.data?[index]
                                        .fishfoodName ??
                                    '-',
                                AppConvertDateTime().dmyName(
                                  widget.plafonFeedUse?.data?[index].datetime ??
                                      DateTime.now(),
                                ),
                                appConvertCurrency(
                                  (widget.plafonFeedUse?.data?[index]
                                              .fishfoodPrice ??
                                          0)
                                      .toDouble(),
                                ),
                              );
                            },
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: widget.plafonTreatmentUse?.data?.isEmpty ?? true
                        ? const AppEmptyData(
                            'Tidak ada data',
                            isCenter: true,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: widget.plafonTreatmentUse?.data?.length,
                            itemBuilder: (context, index) {
                              return feedTabItem(
                                widget.plafonTreatmentUse?.data?[index].name ??
                                    '-',
                                AppConvertDateTime().dmyName(
                                  widget.plafonTreatmentUse?.data?[index]
                                          .datetime ??
                                      DateTime.now(),
                                ),
                                appConvertCurrency(
                                  (widget.plafonTreatmentUse?.data?[index]
                                              .cost ??
                                          0)
                                      .toDouble(),
                                ),
                              );
                            },
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: widget.plafonSeedUse?.data?.isEmpty ?? true
                        ? const AppEmptyData(
                            'Tidak ada data',
                            isCenter: true,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: widget.plafonSeedUse?.data?.length,
                            itemBuilder: (context, index) {
                              return feedTabItem(
                                widget.plafonSeedUse?.data?[index]
                                        .fishseedName ??
                                    '-',
                                AppConvertDateTime().dmyName(
                                  widget.plafonSeedUse?.data?[index]
                                          .tebarDate ??
                                      DateTime.now(),
                                ),
                                appConvertCurrency(
                                  (widget.plafonSeedUse?.data?[index].cost ?? 0)
                                      .toDouble(),
                                ),
                              );
                            },
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: widget.plafonAnotherUse?.data?.isEmpty ?? true
                        ? const AppEmptyData(
                            'Tidak ada data',
                            isCenter: true,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: widget.plafonAnotherUse?.data?.length,
                            itemBuilder: (context, index) {
                              return feedTabItem(
                                widget.plafonAnotherUse?.data?[index].type ??
                                    '-',
                                AppConvertDateTime().dmyName(
                                  widget.plafonAnotherUse?.data?[index].date ??
                                      DateTime.now(),
                                ),
                                appConvertCurrency(
                                  (widget.plafonAnotherUse?.data?[index].cost ??
                                          0)
                                      .toDouble(),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 18.0),
        summarySection(),
        const SizedBox(height: 18.0),
        Expanded(child: historyData()),
      ],
    );
  }
}
