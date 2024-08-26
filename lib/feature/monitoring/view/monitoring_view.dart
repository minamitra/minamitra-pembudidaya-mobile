import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/section/cultivation_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/section/finance_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class MonitoringView extends StatefulWidget {
  const MonitoringView({super.key});

  @override
  State<MonitoringView> createState() => _MonitoringViewState();
}

class _MonitoringViewState extends State<MonitoringView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBar() {
      return Container(
        height: 60,
        decoration: BoxDecoration(color: AppColor.neutral[50]),
        child: TabBar(
          controller: _tabController,
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
          labelPadding: const EdgeInsets.all(0),
          tabs: const [
            Tab(text: 'Budidaya'),
            Tab(text: 'Keuangan'),
          ],
        ),
      );
    }

    Widget bodyTab() {
      return TabBarView(
        controller: _tabController,
        children: [
          CultivationView(),
          FinanceView(),
        ],
      );
    }

    return Column(
      children: [
        tabBar(),
        Expanded(
          child: bodyTab(),
        ),
      ],
    );
  }
}
