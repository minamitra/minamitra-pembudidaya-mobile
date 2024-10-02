import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/views/incident_data/incident_data_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident/views/incident_history/incident_history_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityIncidentView extends StatefulWidget {
  const ActivityIncidentView({super.key});

  @override
  State<ActivityIncidentView> createState() => _ActivityIncidentViewState();
}

class _ActivityIncidentViewState extends State<ActivityIncidentView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Tab> listTab = const [
    Tab(text: 'Berjalan'),
    Tab(text: 'Riwayat'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: listTab.length, vsync: this);
    super.initState();
  }

  Widget tabBar() {
    return SizedBox(
      height: 60,
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColor.primary,
        indicatorWeight: 2.5,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        labelColor: AppColor.primary,
        unselectedLabelColor: AppColor.neutral[400],
        labelStyle: appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
        unselectedLabelStyle:
            appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        isScrollable: false,
        tabs: listTab,
      ),
    );
  }

  Widget bodyTab() {
    return Expanded(
      child: Container(
        color: AppColor.neutral[100],
        child: TabBarView(
          controller: _tabController,
          children: const [
            IncidentDataView(),
            IncidentHistoryView(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tabBar(),
        const SizedBox(height: 8.0),
        bodyTab(),
      ],
    );
  }
}
