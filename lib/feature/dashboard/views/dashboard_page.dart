import 'package:minamitra_pembudidaya_mobile/feature/dashboard/components/dashboard_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/views/home_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/views/transaction_page.dart';

class DashboardPage extends StatefulWidget {
  int currentIndex;
  DashboardPage({this.currentIndex = 0, super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: "/dashboard");

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> currentScrenList = const [
    HomePage(),
    TransactionPage(),
    Placeholder(),
    Placeholder(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScrenList[widget.currentIndex],
      ),
      bottomNavigationBar: DashboardBottomNavigationBar(
        widget.currentIndex,
        (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
      ),
    );
  }
}
