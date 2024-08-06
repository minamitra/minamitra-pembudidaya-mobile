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

class _TransactionViewState extends State<TransactionView> {
  List<String> menus = [
    "Belum Dibayar",
    "Diproses",
    "Selesai",
    "Dibatalkan",
  ];
  int menuIndex = 0;

  Widget menuSelect() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: menus.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                menuIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              decoration: BoxDecoration(
                color: AppColor.white,
                border: Border(
                  bottom: BorderSide(
                    color:
                        menuIndex == index ? AppColor.primary : AppColor.white,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                menus[index],
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodyMedium?.copyWith(
                      fontWeight: menuIndex == index
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: menuIndex == index
                          ? AppColor.primary
                          : AppColor.black[400],
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget menu() {
    switch (menuIndex) {
      case 0:
        return const TransactionUnpaidSection();
      case 1:
        return const TransactionProcessSection();
      case 2:
        return const TransactionDoneSection();
      case 3:
        return const TransactionCancelSection();
      default:
        return const TransactionUnpaidSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        menuSelect(),
        const SizedBox(height: 16),
        Expanded(
          child: menu(),
        ),
      ],
    );
  }
}
