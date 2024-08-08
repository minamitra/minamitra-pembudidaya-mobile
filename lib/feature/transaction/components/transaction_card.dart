import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/transaction_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionCard extends StatefulWidget {
  final TransactionData data;
  final ProductType type;

  const TransactionCard(this.data, this.type, {super.key});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  int? selectedPaymentMethod;

  Function() unpaidShowModal(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        builder: (modalContext) {
          return StatefulBuilder(
            builder: (stateContext, setModalState) {
              return AppBottomSheet(
                "Metode Pembayaran",
                height: MediaQuery.of(context).size.height * 0.5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rekomendasi Metode Pembayaran',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleMedium?.copyWith(
                              color: AppColor.black,
                            ),
                      ),
                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listMethodPayment.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setModalState(() {
                                selectedPaymentMethod = index;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColor.primary[50],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Image.asset(
                                    listMethodPayment[index].icon,
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listMethodPayment[index].name,
                                        textAlign: TextAlign.start,
                                        style: appTextTheme(context)
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.black,
                                            ),
                                      ),
                                      Text(
                                        listMethodPayment[index].description,
                                        textAlign: TextAlign.start,
                                        style: appTextTheme(context)
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.black[400],
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Radio<int>(
                                  value: index,
                                  groupValue: selectedPaymentMethod,
                                  onChanged: (int? value) {
                                    setModalState(() {
                                      selectedPaymentMethod = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      AppPrimaryFullButton(
                        "Konfirmasi",
                        () {},
                        height: 56,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(AppTransition.pushTransition(
          const TransactionDetailPage(),
          TransactionDetailPage.routeSettings(),
        ));
      },
      child: AppDefaultCard(
        isShadow: false,
        borderRadius: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.type == ProductType.process
                ? Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      widget.data.status!,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.primary,
                          ),
                    ),
                  )
                : const SizedBox(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    widget.data.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.title,
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.black,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.data.productType,
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.black[400],
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              appConvertCurrency(widget.data.price),
                              textAlign: TextAlign.start,
                              style: appTextTheme(context).bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.black,
                                  ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "x${widget.data.amount}",
                              textAlign: TextAlign.end,
                              style: appTextTheme(context).bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 32,
              thickness: 0.5,
              color: AppColor.black[400],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1 Item",
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.black[400],
                      ),
                ),
                Text(
                  appConvertCurrency(widget.data.price * widget.data.amount),
                  textAlign: TextAlign.end,
                  style: appTextTheme(context).bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.accent,
                      ),
                ),
              ],
            ),
            widget.type == ProductType.unpaid
                ? Column(
                    children: [
                      Divider(
                        height: 32,
                        thickness: 0.5,
                        color: AppColor.black[400],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bayar Sekarang",
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          SizedBox(
                            height: 40,
                            child: AppPrimaryButton(
                              "Bayar",
                              unpaidShowModal(context),
                              width: 96,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            widget.type == ProductType.done
                ? Column(
                    children: [
                      Divider(
                        height: 32,
                        thickness: 0.5,
                        color: AppColor.black[400],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pesan Lagi Yuk",
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          SizedBox(
                            height: 40,
                            child: AppPrimaryButton(
                              "Ulas",
                              () {},
                              width: 96,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
            widget.type == ProductType.cancel
                ? Column(
                    children: [
                      Divider(
                        height: 32,
                        thickness: 0.5,
                        color: AppColor.black[400],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pesanan Dibatalkan",
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          SizedBox(
                            height: 40,
                            child: AppPrimaryButton(
                              "Beli Lagi",
                              () {},
                              width: 96,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
