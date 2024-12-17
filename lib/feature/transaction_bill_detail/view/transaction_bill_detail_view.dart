import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionBillDetailView extends StatefulWidget {
  const TransactionBillDetailView({super.key});

  @override
  State<TransactionBillDetailView> createState() =>
      _TransactionBillDetailViewState();
}

class _TransactionBillDetailViewState extends State<TransactionBillDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
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
              '50%',
              'Rp 100.000',
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              'Perlakuan',
              '50%',
              'Rp 100.000',
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              'Bibit/Benih',
              '50%',
              'Rp 100.000',
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              'Pembelian',
              '50%',
              'Rp 100.000',
            ),
            const SizedBox(height: 18.0),
            summaryItem(
              'Lainnya',
              '50%',
              'Rp 100.000',
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

    Widget feedTabView() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            feedTabItem(
              'Pakan Pagi',
              '05-08-2024 17:00 WIB',
              '- Rp 100.000',
            ),
            feedTabItem(
              'Pakan Pagi',
              '05-08-2024 17:00 WIB',
              '- Rp 100.000',
            ),
            feedTabItem(
              'Pakan Pagi',
              '05-08-2024 17:00 WIB',
              '- Rp 100.000',
            ),
            feedTabItem(
              'Pakan Pagi',
              '05-08-2024 17:00 WIB',
              '- Rp 100.000',
            ),
            feedTabItem(
              'Pakan Pagi',
              '05-08-2024 17:00 WIB',
              '- Rp 100.000',
            ),
            feedTabItem(
              'Pakan Pagi',
              '05-08-2024 17:00 WIB',
              '- Rp 100.000',
            ),
          ],
        ),
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
                  Tab(text: 'Pembelian'),
                  Tab(text: 'Lainnya'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  feedTabView(),
                  feedTabView(),
                  feedTabView(),
                  feedTabView(),
                  feedTabView(),
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
