import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/components/transaction_card.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/transaction_data.dart';

class TransactionUnpaidSection extends StatefulWidget {
  const TransactionUnpaidSection({super.key});

  @override
  State<TransactionUnpaidSection> createState() =>
      _TransactionUnpaidSectionState();
}

class _TransactionUnpaidSectionState extends State<TransactionUnpaidSection> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_, index) {
        return const SizedBox(height: 16);
      },
      itemCount: listTransaction.length,
      itemBuilder: (context, index) {
        return TransactionCard(listTransaction[index], ProductType.unpaid);
      },
    );
  }
}
