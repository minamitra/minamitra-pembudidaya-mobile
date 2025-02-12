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

class TransactionCancelSection extends StatefulWidget {
  const TransactionCancelSection({super.key});

  @override
  State<TransactionCancelSection> createState() =>
      _TransactionCancelSectionState();
}

class _TransactionCancelSectionState extends State<TransactionCancelSection> {
  @override
  void initState() {
    super.initState();
    if (context.read<TransactionCubit>().state.cancelDatas == null) {
      context.read<TransactionCubit>().getCanceledDatas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return bodyShimmer();
        }

        if (state.cancelDatas?.data?.isEmpty ?? true) {
          return AppRefresher(
            onRefresh: () {
              context.read<TransactionCubit>().getCanceledDatas();
            },
            child: const AppEmptyData(
              'Tidak ada data transaksi',
              isCenter: true,
            ),
          );
        }

        return AppRefresher(
          onRefresh: () {
            context.read<TransactionCubit>().getCanceledDatas();
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
            itemCount: state.cancelDatas?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TransactionCard(
                state.cancelDatas!.data![index],
                ProductType.cancel,
                onRefresh: () {
                  context.read<TransactionCubit>().getCanceledDatas();
                  context.read<TransactionCubit>().getDoneDatas();
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
