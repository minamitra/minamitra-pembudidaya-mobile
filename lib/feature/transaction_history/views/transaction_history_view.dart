import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_history/repositories/transaction_history_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionHistoryView extends StatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  Widget cardItem(TransactionHistoryItem data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          data.icon,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                data.description,
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: AppColor.neutral[500],
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        data.status == TransactionHistoryStatus.income
            ? Text(
                '+${appConvertCurrency(data.amount)}',
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.secondary,
                    ),
              )
            : Text(
                '-${appConvertCurrency(data.amount)}',
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.accent,
                    ),
              ),
      ],
    );
  }

  Widget cardOfDate(TransactionHistory data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConvertDateTime().dmyName(data.date),
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall?.copyWith(
                color: AppColor.neutral[500],
              ),
        ),
        const SizedBox(height: 32),
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(
            height: 32,
            thickness: 1,
            color: AppColor.neutral[100],
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            return cardItem(data.items[index]);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return listTransactionHistoryDummy.isEmpty
        ? const Center(
            child: AppEmptyData(
              'Oops, Belum Ada Riwayat Transaksi',
              isCenter: true,
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            separatorBuilder: (context, index) => Divider(
              height: 32,
              thickness: 1,
              color: AppColor.neutral[100],
            ),
            itemCount: listTransactionHistoryDummy.length,
            itemBuilder: (context, index) {
              return cardOfDate(listTransactionHistoryDummy[index]);
            },
          );
  }
}
