import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/components/transaction_card.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/transaction_data.dart';

class TransactionProcessSection extends StatefulWidget {
  const TransactionProcessSection({super.key});

  @override
  State<TransactionProcessSection> createState() =>
      _TransactionProcessSectionState();
}

class _TransactionProcessSectionState extends State<TransactionProcessSection> {
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
        return TransactionCard(listTransaction[index], ProductType.process);
      },
    );
  }
}
