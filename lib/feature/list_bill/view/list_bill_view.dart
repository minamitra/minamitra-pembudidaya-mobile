import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_detail/view/bill_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/list_bill/logic/list_bill_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/list_bill/repositories/list_bill_filter.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ListBillView extends StatefulWidget {
  const ListBillView({
    required this.isHistoryTransaction,
    super.key,
  });

  final bool isHistoryTransaction;

  @override
  State<ListBillView> createState() => _ListBillViewState();
}

class _ListBillViewState extends State<ListBillView> {
  String badgesText(String status) {
    switch (status) {
      case 'Menunggu':
        return 'Menunggu Konfirmasi Pesanan';
      case 'Diproses':
        return 'Pesanan diproses';
      case 'Dikirim':
        return 'Pesanan sedang dikirim';
      case 'Berjalan':
        return 'Berjalan';
      case 'Dibatalkan':
      case 'Ditolak':
        return 'Pesanan dibatalkan';
      default:
        return 'Tidak diketahui';
    }
  }

  Color badgeBorderColor(String status) {
    switch (status) {
      case 'Jatuh Tempo':
        return AppColor.accent;
      case 'Diproses':
        return const Color(0xFF0EA5E9);
      case 'Tagihan Terbayar':
        return const Color(0xFF0EA5E9);
      case 'Tagihan Aktif':
        return AppColor.green[500]!;
      case 'Dibatalkan':
      case 'Tagihan Telat':
        return AppColor.red[600]!;
      default:
        return AppColor.accent;
    }
  }

  Color badgeColor(String status) {
    switch (status) {
      case 'Jatuh Tempo':
        return AppColor.accent[50]!;
      case 'Diproses':
        return const Color(0xFF0EA5E9);
      case 'Tagihan Terbayar':
        return const Color(0xFF0EA5E9).withOpacity(0.1);
      case 'Tagihan Aktif':
        return AppColor.green[50]!;
      case 'Dibatalkan':
      case 'Tagihan Telat':
        return AppColor.red[50]!;
      default:
        return AppColor.accent[50]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget filter() {
      return BlocBuilder<ListBillCubit, ListBillState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: SizedBox(
              height: 40.0,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: listBillFilter.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 12.0);
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16.0 : 0,
                      right: index == listBillFilter.length - 1 ? 16.0 : 0,
                    ),
                    child: FilterChip(
                      label: Text(
                        listBillFilter[index],
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              color: listBillFilter[index] == state.filter
                                  ? AppColor.primary[500]
                                  : AppColor.neutral[400],
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      selected: listBillFilter[index] == state.filter,
                      onSelected: (value) {
                        if (listBillFilter[index] != state.filter) {
                          context
                              .read<ListBillCubit>()
                              .changeFilter(listBillFilter[index]);
                        }
                      },
                      side: BorderSide(
                        color: listBillFilter[index] == state.filter
                            ? AppColor.secondary
                            : AppColor.transparent,
                      ),
                      selectedColor: AppColor.primary[100],
                      backgroundColor: AppColor.neutral[100],
                      showCheckmark: false,
                      checkmarkColor: AppColor.primary[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    Widget billItemData(
      String title,
      String value,
    ) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).labelSmall?.copyWith(
                  color: const Color(0xFF9CA3AF),
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            textAlign: TextAlign.start,
            style: appTextTheme(context).labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColor.black,
                ),
          ),
        ],
      );
    }

    Widget billItem(
      String title,
      String status,
      String dueDate,
      String billTotal,
      String billRemaining,
    ) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      AppAssets.dymmyActivityImage,
                      width: 32.0,
                      height: 32.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context)
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor(status),
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: badgeBorderColor(status)),
                    ),
                    child: Text(
                      status,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).labelSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: badgeBorderColor(status),
                          ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.0,
                    color: Color(0xFF191C20),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColor.neutral[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: billItemData('Jatuh Tempo', dueDate),
                  ),
                  Expanded(
                    child: billItemData('Total Tagihan', billTotal),
                  ),
                  Expanded(
                    child: billItemData('Kekurangan Bayar', billRemaining),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget listBillItem() {
      return BlocBuilder<ListBillCubit, ListBillState>(
        builder: (context, state) {
          if (state.status.isLoaded &&
              (state.billResponse?.data?.isEmpty ?? true)) {
            return const Center(
              child: AppEmptyData(
                'Tidak ada tagihan',
                descriptions: 'Tidak ada tagihan yang tersedia/ditemukan',
                isCenter: true,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            itemCount: state.status.isLoading
                ? 10
                : state.billResponse?.data?.length ?? 0,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const SizedBox(height: 18.0);
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? EdgeInsets.only(
                        top: widget.isHistoryTransaction ? 18.0 : 0,
                      )
                    : EdgeInsets.zero,
                child: state.status.isLoading
                    ? const AppShimmer(
                        120,
                        double.infinity,
                        8.0,
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            AppTransition.pushTransition(
                              BillDetailPage(
                                isHistoryTransaction:
                                    widget.isHistoryTransaction,
                                billResponseData:
                                    state.billResponse!.data![index],
                              ),
                              BillDetailPage.routeSettings(),
                            ),
                          );
                        },
                        child: billItem(
                          state.billResponse?.data?[index].fishpondName
                                  .handlingEmptyString() ??
                              '-',
                          state.billResponse?.data?[index].paymentStatus
                                  .handlingEmptyString() ??
                              'Tagihan Aktif',
                          AppConvertDateTime().dmyName(
                            state.billResponse?.data?[index].dueDate ??
                                DateTime.now(),
                          ),
                          appConvertCurrency(
                            state.billResponse?.data?[index].invoiceNominal
                                    ?.toDouble() ??
                                0.0,
                          ),
                          appConvertCurrency(
                            state.billResponse?.data?[index].remainingNominal
                                    ?.toDouble() ??
                                0.0,
                          ),
                        ),
                      ),
              );
            },
          );
        },
      );
    }

    return Column(
      children: [
        if (!widget.isHistoryTransaction) filter(),
        if (!widget.isHistoryTransaction) const SizedBox(height: 6.0),
        Expanded(child: listBillItem()),
      ],
    );
  }
}
