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

class TransactionUnpaidSection extends StatefulWidget {
  const TransactionUnpaidSection({super.key});

  @override
  State<TransactionUnpaidSection> createState() =>
      _TransactionUnpaidSectionState();
}

class _TransactionUnpaidSectionState extends State<TransactionUnpaidSection> {
  @override
  void initState() {
    super.initState();
    if (context.read<TransactionCubit>().state.waitingDatas == null) {
      context.read<TransactionCubit>().getWaitingDatas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return bodyShimmer();
        }

        if (state.waitingDatas?.data?.isEmpty ?? true) {
          return AppRefresher(
            onRefresh: () {
              context.read<TransactionCubit>().getWaitingDatas();
            },
            child: const AppEmptyData(
              'Tidak ada data transaksi',
              isCenter: true,
            ),
          );
        }

        return AppRefresher(
          onRefresh: () {
            context.read<TransactionCubit>().getWaitingDatas();
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
            itemCount: state.waitingDatas?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TransactionCard(
                state.waitingDatas!.data![index],
                ProductType.unpaid,
                onRefresh: () {
                  context.read<TransactionCubit>().getWaitingDatas();
                  context.read<TransactionCubit>().getProcessDatas();
                  context.read<TransactionCubit>().getCanceledDatas();
                },
                uploadPaymentProof: (file, notes) {
                  context.read<TransactionCubit>().uploadPaymentProof(
                        state.waitingDatas!.data![index].id ?? '',
                        file,
                        notes,
                      );
                },
              );
            },
          ),
        );
      },
    );
  }
}
