import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/sections/transaction_cancel_section.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/sections/transaction_done_section.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/sections/transaction_process_section.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/sections/transaction_unpaid_section.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
          tabs: const [
            Tab(text: 'Menunggu'),
            Tab(text: 'Diproses'),
            Tab(text: 'Selesai'),
            Tab(text: 'Dibatalkan'),
          ],
        ),
      );
    }

    Widget bodyTab() {
      return Expanded(
        child: TabBarView(
          controller: _tabController,
          children: const [
            TransactionUnpaidSection(),
            TransactionProcessSection(),
            TransactionDoneSection(),
            TransactionCancelSection(),
          ],
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        tabBar(),
        Expanded(
          child: bodyTab(),
        ),
      ],
    );
  }
}
