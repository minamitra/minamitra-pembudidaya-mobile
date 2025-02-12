import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_refresher.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/components/transaction_card.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/transaction_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/logic/transaction_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/sections/body_shimmer.dart';

class TransactionDoneSection extends StatefulWidget {
  const TransactionDoneSection({super.key});

  @override
  State<TransactionDoneSection> createState() => _TransactionDoneSectionState();
}

class _TransactionDoneSectionState extends State<TransactionDoneSection> {
  @override
  void initState() {
    super.initState();
    if (context.read<TransactionCubit>().state.doneDatas == null) {
      context.read<TransactionCubit>().getDoneDatas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return bodyShimmer();
        }

        if (state.doneDatas?.data?.isEmpty ?? true) {
          return AppRefresher(
            onRefresh: () {
              context.read<TransactionCubit>().getDoneDatas();
            },
            child: const AppEmptyData(
              'Tidak ada data transaksi',
              isCenter: true,
            ),
          );
        }

        return AppRefresher(
          onRefresh: () {
            context.read<TransactionCubit>().getDoneDatas();
          },
          child: ListView.separated(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (_, index) {
              return AppDivider(
                color: AppColor.neutral[100],
                thickness: 18.0,
              );
            },
            itemCount: state.doneDatas?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TransactionCard(
                state.doneDatas!.data![index],
                ProductType.done,
                onRefresh: () {
                  context.read<TransactionCubit>().getDoneDatas();
                  context.read<TransactionCubit>().getCanceledDatas();
                },
                uploadPaymentProof: (File file, String notes) {},
              );
            },
          ),
        );
      },
    );
  }
}
