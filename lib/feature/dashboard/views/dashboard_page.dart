import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/dashboard/dashboard_bottom_nav_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/view/activity_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/components/dashboard_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/views/home_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile/view/profile_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/views/transaction_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/dashboard");

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> currentScrenList = const [
    HomePage(),
    TransactionPage(),
    ActivityPage(),
    ProfilePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: PageStorage(
            bucket: bucket,
            child: currentScrenList[state],
          ),
          bottomNavigationBar: DashboardBottomNavigationBar(
            state,
            (index) {
              context.read<DashboardBottomNavCubit>().changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
