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

class TransactionProcessSection extends StatefulWidget {
  const TransactionProcessSection({super.key});

  @override
  State<TransactionProcessSection> createState() =>
      _TransactionProcessSectionState();
}

class _TransactionProcessSectionState extends State<TransactionProcessSection> {
  @override
  void initState() {
    super.initState();
    if (context.read<TransactionCubit>().state.processDatas == null) {
      context.read<TransactionCubit>().getProcessDatas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return bodyShimmer();
        }

        if (state.processDatas?.data?.isEmpty ?? true) {
          return AppRefresher(
            onRefresh: () {
              context.read<TransactionCubit>().getProcessDatas();
            },
            child: const AppEmptyData(
              'Tidak ada data transaksi',
              isCenter: true,
            ),
          );
        }

        return AppRefresher(
          onRefresh: () {
            context.read<TransactionCubit>().getProcessDatas();
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
            itemCount: state.processDatas?.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TransactionCard(
                state.processDatas!.data![index],
                ProductType.process,
                onRefresh: () {
                  context.read<TransactionCubit>().getProcessDatas();
                  context.read<TransactionCubit>().getCanceledDatas();
                  context.read<TransactionCubit>().getDoneDatas();
                },
                uploadPaymentProof: (file, notes) {
                  context.read<TransactionCubit>().uploadPaymentProof(
                        state.processDatas!.data![index].id ?? '',
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
