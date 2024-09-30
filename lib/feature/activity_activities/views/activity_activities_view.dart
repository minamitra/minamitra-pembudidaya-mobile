import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/activity_activities_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/sampling_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/treatment_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/feeding/feeding_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/sampling/sampling_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/treatment/treatment_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/views/water_quality/water_quality_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ActivityActivitiesView extends StatefulWidget {
  final int fishpondId;
  final int fishpondcycleId;

  const ActivityActivitiesView(
    this.fishpondId,
    this.fishpondcycleId, {
    super.key,
  });

  @override
  State<ActivityActivitiesView> createState() => _ActivityActivitiesViewState();
}

class _ActivityActivitiesViewState extends State<ActivityActivitiesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      context.read<ActivityActivitiesCubit>().changeIndex(_tabController.index);
    });
    super.initState();
  }

  Widget tabBar() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: AppColor.white),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColor.primary,
        indicatorWeight: 2.5,
        padding: EdgeInsets.zero,
        labelColor: AppColor.primary,
        unselectedLabelColor: AppColor.neutral[400],
        labelStyle: appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
        unselectedLabelStyle:
            appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
        labelPadding: const EdgeInsets.all(0),
        isScrollable: false,
        tabs: const [
          Tab(text: 'Pakan'),
          Tab(text: 'Perlakuan'),
          Tab(text: 'Sampling'),
          Tab(text: 'Kualitas Air'),
        ],
      ),
    );
  }

  Widget bodyTab() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [
          FeedingView(),
          TreatmentView(),
          SamplingView(),
          WaterQualityView(),
        ],
      ),
    );
  }

  Widget calendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: EasyDateTimeLine(
        activeColor: AppColor.primary,
        initialDate: DateTime.now(),
        locale: 'in_ID',
        onDateChange: (selectedDate) {
          //`selectedDate` the new date selected.
          String finalDate = AppConvertDateTime().ymdDash(selectedDate);
          context.read<TreatmentCubit>().init(
                widget.fishpondId,
                widget.fishpondcycleId,
                finalDate,
              );
          context.read<SamplingCubit>().init(
                widget.fishpondId,
                widget.fishpondcycleId,
                finalDate,
              );
        },
        headerProps: const EasyHeaderProps(
          dateFormatter: DateFormatter.monthOnly(),
        ),
        dayProps: EasyDayProps(
          height: 76,
          dayStructure: DayStructure.dayNumDayStr,
          inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        calendar(),
        const SizedBox(height: 16.0),
        tabBar(),
        bodyTab(),
      ],
    );
  }
}
