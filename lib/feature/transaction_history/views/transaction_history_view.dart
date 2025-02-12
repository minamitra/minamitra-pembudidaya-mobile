import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/history_balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_history/logic/transaction_history_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_history/repositories/transaction_history_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionHistoryView extends StatefulWidget {
  const TransactionHistoryView({super.key});

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState extends State<TransactionHistoryView> {
  Widget cardItem(HistoryBalanceResponseData data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          data.category?.contains('Pengajuan') ?? false
              ? AppAssets.walletOutlineIcon
              : AppAssets.qrCodeIcon,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.category.handlingEmptyString(),
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                data.desc.handlingEmptyString(),
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: AppColor.neutral[500],
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        data.type == 'in'
            ? Text(
                '+${appConvertCurrency((data.nominal ?? 0).toDouble())}',
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.secondary,
                    ),
              )
            : Text(
                '-${appConvertCurrency((data.nominal ?? 0).toDouble())}',
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.accent,
                    ),
              ),
      ],
    );
  }

  Widget cardOfDate(List<HistoryBalanceResponseData> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConvertDateTime().dmyName(data.first.dateTime ?? DateTime.now()),
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
          itemCount: data.length,
          itemBuilder: (context, index) {
            return cardItem(data[index]);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
      builder: (context, state) {
        if (state.status == GlobalState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return state.historyBalance?.data?.isEmpty ?? true
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
                itemCount: state.dataFormated?.keys.length ?? 0,
                itemBuilder: (context, index) {
                  return cardOfDate(
                    state.dataFormated![
                        state.dataFormated?.keys.elementAt(index)]!,
                  );
                },
              );
      },
    );
  }
}
