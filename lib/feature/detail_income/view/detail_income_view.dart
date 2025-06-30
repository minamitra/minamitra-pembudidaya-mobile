import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_cycle_add_harvest/repositories/buyer_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_income/logic/detail_income_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class DetailIncomeView extends StatefulWidget {
  const DetailIncomeView(this.totalIncome, {super.key});

  final double totalIncome;

  @override
  State<DetailIncomeView> createState() => _DetailIncomeViewState();
}

class _DetailIncomeViewState extends State<DetailIncomeView> {
  @override
  Widget build(BuildContext context) {
    Widget summaryCard() {
      return Container(
        margin: const EdgeInsets.all(18.0),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: AppColor.secondary[900],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondary[900]!.withOpacity(0.24),
              blurRadius: 24.0,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Pendapatan',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.secondary[300],
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    appConvertCurrency(widget.totalIncome),
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                  ),
                ],
              ),
            ),
            Image.asset(
              AppAssets.totalIncomeSummaryIcon,
              height: 40.0,
              width: 40.0,
            ),
          ],
        ),
      );
    }

    Widget transactionTitle() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Text(
          'Transaksi',
          textAlign: TextAlign.start,
          style: appTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.black,
              ),
        ),
      );
    }

    Widget transactionItem(BuyerData data) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        color: AppColor.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Harga per Kg',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: AppColor.neutral[500]),
                  ),
                ),
                Text(
                  '${appConvertCurrency(data.sellUnitPrice.toDouble())}/kg',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Terjual',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: AppColor.neutral[500]),
                  ),
                ),
                Text(
                  'x ${data.sellRequest}kg',
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            const AppDottedLine(),
            const SizedBox(height: 18.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sub Total',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context)
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  appConvertCurrency(data.sellTotalPrice.toDouble()),
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget listItem() {
      return BlocBuilder<DetailIncomeCubit, DetailIncomeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 18.0);
              },
              itemBuilder: (context, index) {
                return const AppShimmer(
                  124.0,
                  double.infinity,
                  0.0,
                );
              },
            );
          }

          if (state.data?.buyerJsonArray?.isEmpty ?? true) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.25,
              ),
              child: const AppEmptyData(
                'Belum ada data ditambahkan',
                isCenter: true,
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.data?.buyerJsonArray?.length ?? 0,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 18.0);
            },
            itemBuilder: (context, index) {
              return transactionItem(state.data!.buyerJsonArray![index]);
            },
          );
        },
      );
    }

    return ListView(
      children: [
        summaryCard(),
        const SizedBox(height: 8.0),
        transactionTitle(),
        const SizedBox(height: 18.0),
        listItem(),
      ],
    );
  }
}
