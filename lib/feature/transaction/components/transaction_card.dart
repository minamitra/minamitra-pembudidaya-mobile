import 'dart:io';

import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/adress_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/components/upload_payment_proof.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/transaction_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/transaction_dummy_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/repositories/transaction_item_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionCard extends StatefulWidget {
  final TransactionItemResponseData data;
  final ProductType type;
  final void Function() onRefresh;
  final void Function(
    File file,
    String notes,
  ) uploadPaymentProof;

  const TransactionCard(
    this.data,
    this.type, {
    required this.onRefresh,
    required this.uploadPaymentProof,
    super.key,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  int? selectedPaymentMethod;
  int? selectedPaymentBank;

  Function() unpaidShowModal(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        builder: (modalContext) {
          return StatefulBuilder(
            builder: (stateContext, setModalState) {
              return AppBottomSheet(
                'Metode Pembayaran',
                height: MediaQuery.of(context).size.height * 0.5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              'Rekomendasi Metode Pembayaran',
                              textAlign: TextAlign.start,
                              style:
                                  appTextTheme(context).titleMedium?.copyWith(
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
                                      selectedPaymentBank = null;
                                      selectedPaymentMethod = index;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.primary[50],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.asset(
                                          listMethodPayment[index].icon,
                                          width: 40,
                                          height: 40,
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
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.black,
                                                  ),
                                            ),
                                            Text(
                                              listMethodPayment[index]
                                                  .description,
                                              textAlign: TextAlign.start,
                                              style: listMethodPayment[index]
                                                          .name ==
                                                      'Plafon'
                                                  ? appTextTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: AppColor
                                                            .primary[500],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )
                                                  : appTextTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.black[400],
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
                                            selectedPaymentBank = null;
                                            selectedPaymentMethod = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Transfer Bank',
                              textAlign: TextAlign.start,
                              style:
                                  appTextTheme(context).titleMedium?.copyWith(
                                        color: AppColor.black,
                                      ),
                            ),
                            const SizedBox(height: 16),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listMethodBank.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setModalState(() {
                                      selectedPaymentMethod = null;
                                      selectedPaymentBank = index;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.primary[50],
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.asset(
                                          listMethodBank[index].icon,
                                          width: 40,
                                          height: 40,
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
                                              listMethodBank[index].name,
                                              textAlign: TextAlign.start,
                                              style: appTextTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.black,
                                                  ),
                                            ),
                                            Text(
                                              listMethodBank[index].description,
                                              textAlign: TextAlign.start,
                                              style: listMethodBank[index]
                                                          .name ==
                                                      'Plafon'
                                                  ? appTextTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: AppColor
                                                            .primary[500],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )
                                                  : appTextTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.black[400],
                                                      ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Radio<int>(
                                        value: index,
                                        groupValue: selectedPaymentBank,
                                        onChanged: (int? value) {
                                          setModalState(() {
                                            selectedPaymentMethod = null;
                                            selectedPaymentBank = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppPrimaryFullButton(
                        'Konfirmasi',
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

  Widget bodyItems(OrderDetail data) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                data.itemImageUrl ?? '',
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
                    data.itemName.handlingEmptyString(),
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data.itemCategoryName.handlingEmptyString(),
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
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
                          appConvertCurrency(
                            double.parse(data.itemSellPrice ?? '0'),
                          ),
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.black,
                              ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'x${data.qty}',
                          textAlign: TextAlign.end,
                          style: appTextTheme(context).bodySmall?.copyWith(
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
      ],
    );
  }

  Widget totalItemPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${widget.data.orderDetails?.fold(
            0,
            (previousElement, element) {
              return previousElement + int.parse(element.qty ?? '0');
            },
          )} Item',
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.black[400],
              ),
        ),
        Text(
          appConvertCurrency(double.parse(widget.data.totalItemPrice ?? '0')),
          textAlign: TextAlign.end,
          style: appTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.accent,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(
          AppTransition.pushTransition(
            TransactionDetailPage(data: widget.data),
            TransactionDetailPage.routeSettings(),
          ),
        )
            .then((value) {
          if (value == 'refresh') {
            widget.onRefresh();
          }
        });
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
                      style: appTextTheme(context).bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.primary,
                          ),
                    ),
                  )
                : const SizedBox(),
            ...List.generate(
              widget.data.orderDetails?.length ?? 0,
              (index) {
                return bodyItems(widget.data.orderDetails![index]);
              },
            ),
            totalItemPrice(),
            (widget.type == ProductType.process ||
                        widget.type == ProductType.unpaid) &&
                    widget.data.paymentStatus == 'Belum Terbayar'
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
                            'Verifikasi pembayaran',
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          SizedBox(
                            height: 40,
                            child: AppPrimaryButton(
                              'Upload Bukti',
                              uploadPaymentProof(
                                context,
                                (file, notes) {
                                  widget.uploadPaymentProof(file, notes);
                                },
                              ),
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
                            'Pesanan Selesai',
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          Text(
                            AppConvertDateTime().dmyName(
                              widget.data.doneDatetime ?? DateTime.now(),
                            ),
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          // SizedBox(
                          //   height: 40,
                          //   child: AppPrimaryButton(
                          //     'Beli Lagi',
                          //     () {},
                          //     width: 96,
                          //   ),
                          // ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Pesan Lagi Yuk',
                      //       textAlign: TextAlign.start,
                      //       style: appTextTheme(context).bodySmall?.copyWith(
                      //             fontWeight: FontWeight.w400,
                      //             color: AppColor.black[400],
                      //           ),
                      //     ),
                      //     SizedBox(
                      //       height: 40,
                      //       child: AppPrimaryButton(
                      //         'Ulas',
                      //         () {},
                      //         width: 96,
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
                            'Pesanan Dibatalkan',
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          Text(
                            AppConvertDateTime().dmyName(
                              widget.data.datetime ?? DateTime.now(),
                            ),
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.black[400],
                                ),
                          ),
                          // SizedBox(
                          //   height: 40,
                          //   child: AppPrimaryButton(
                          //     'Beli Lagi',
                          //     () {},
                          //     width: 96,
                          //   ),
                          // ),
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
