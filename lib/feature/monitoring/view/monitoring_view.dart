import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/monitoring_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/section/cultivation_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/section/finance_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/view/section/resume_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class MonitoringView extends StatefulWidget {
  const MonitoringView(
    this.pondID,
    this.pondCycleID, {
    required this.isCycleDone,
    super.key,
  });

  final String pondID;
  final String pondCycleID;
  final bool isCycleDone;

  @override
  State<MonitoringView> createState() => _MonitoringViewState();
}

class _MonitoringViewState extends State<MonitoringView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      context.read<MonitoringCubit>().onChangeIndex(_tabController.index);
    });

    if (widget.isCycleDone) {
      context.read<CultivationCubit>().setupData(
            widget.pondID,
            widget.pondCycleID,
          );
    }

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
            Tab(text: 'Resume'),
          ],
        ),
      );
    }

    Widget bodyTab() {
      return TabBarView(
        controller: _tabController,
        children: [
          widget.isCycleDone
              ? const AppEmptyData(
                  'Siklus Berakhir',
                  descriptions:
                      'Silahkan buat siklus baru untuk melihat analisa data',
                  isCenter: true,
                )
              : const CultivationView(),
          FinanceView(),
          ResumeView(),
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
