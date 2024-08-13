import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/components/transaction_card.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/transaction_data.dart';

class TransactionDoneSection extends StatefulWidget {
  const TransactionDoneSection({super.key});

  @override
  State<TransactionDoneSection> createState() => _TransactionDoneSectionState();
}

class _TransactionDoneSectionState extends State<TransactionDoneSection> {
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
        return TransactionCard(listTransaction[index], ProductType.done);
      },
    );
  }
}
