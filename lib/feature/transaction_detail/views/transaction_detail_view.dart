import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/adress_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/components/upload_payment_proof.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/repositories/transaction_item_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/logic/transaction_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/detail_delivery/detail_delivery_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionDetailView extends StatefulWidget {
  final List<ProductsResponseData> listProduct;
  final List<int> listAmountItem;
  final Address address;
  final MethodPaymentData methodPayment;
  final TransactionItemResponseData data;

  const TransactionDetailView(
    this.listProduct,
    this.listAmountItem,
    this.address,
    this.methodPayment,
    this.data, {
    super.key,
  });

  @override
  State<TransactionDetailView> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends State<TransactionDetailView> {
  final TextEditingController noteController = TextEditingController();
  List<Uint8List> listImage = [];

  String badgesText() {
    switch (widget.data.status) {
      case 'Menunggu':
        return 'Menunggu Konfirmasi Pesanan';
      case 'Diproses':
        return 'Pesanan diproses';
      case 'Dikirim':
        return 'Pesanan sedang dikirim';
      case 'Selesai':
        return 'Pesanan selesai';
      case 'Dibatalkan':
      case 'Ditolak':
        return 'Pesanan dibatalkan';
      default:
        return 'Tidak diketahui';
    }
  }

  Color badgeColor() {
    switch (widget.data.status) {
      case 'Menunggu':
        return AppColor.accent;
      case 'Diproses':
        return const Color(0xFF0EA5E9);
      case 'Dikirim':
        return const Color(0xFF0EA5E9);
      case 'Selesai':
        return const Color(0xFF14B8A6);
      case 'Dibatalkan':
      case 'Ditolak':
        return AppColor.red[600]!;
      default:
        return AppColor.accent;
    }
  }

  Widget statusBar(BuildContext context) {
    return Column(
      children: [
        if ((widget.data.status == 'Menunggu' ||
                widget.data.status == 'Diproses' ||
                widget.data.status == 'Dikirim') &&
            widget.data.paymentStatus == 'Belum Terbayar')
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
            margin: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              bottom: 18.0,
            ),
            decoration: BoxDecoration(
              color: AppColor.accent[50],
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColor.accent[500]!),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColor.accent,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Silahkan melakukan pembayaran sebelum tanggal ',
                          style: appTextTheme(context)
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '${AppConvertDateTime().dmyName(
                            widget.data.paymentDueDatetime ?? DateTime.now(),
                          )} ${AppConvertDateTime().jm24(
                            widget.data.paymentDueDatetime ?? DateTime.now(),
                          )}',
                          style: appTextTheme(context)
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        if ((widget.data.status == 'Menunggu' ||
                widget.data.status == 'Diproses' ||
                widget.data.status == 'Dikirim') &&
            widget.data.paymentStatus == 'Menunggu Verifikasi Pembayaran')
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 12.0,
            ),
            margin: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              bottom: 18.0,
            ),
            decoration: BoxDecoration(
              color: AppColor.accent[50],
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: AppColor.accent[500]!),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppColor.accent,
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    'Silahkan tunggu. Pembayaran kamu sedang diverifikasi',
                    style: appTextTheme(context).labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: badgeColor(),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            badgesText(),
            textAlign: TextAlign.center,
            style: appTextTheme(context).bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColor.white,
                ),
          ),
        ),
      ],
    );
  }

  Widget transferBankItem({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: appTextTheme(context).bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9CA3AF),
                    ),
              ),
              const SizedBox(height: 4.0),
              Text(
                value,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: value)).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title Berhasil disalin'),
                ),
              );
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColor.primary[600]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.copy,
                  size: 20.0,
                  color: AppColor.primary[600],
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Salin',
                  style: appTextTheme(context).titleSmall?.copyWith(
                        color: AppColor.primary[600],
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget paymentMethod(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metode Pembayaran',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: widget.data.paymentMethod == 'Transfer'
                    ? Image.network(
                        widget.data.paymentTransferBankImageUrl ?? '',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        widget.methodPayment.icon,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.paymentMethod == 'Transfer'
                          ? widget.data.paymentTransferBankName
                              .handlingEmptyString()
                          : widget.data.paymentMethod.handlingEmptyString(),
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black,
                          ),
                    ),
                    Text(
                      widget.data.paymentMethod == 'Transfer'
                          ? widget.data.paymentTransferBankAccountName
                              .handlingEmptyString()
                          : '',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColor.black[400],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (widget.data.paymentMethod == 'Transfer') ...[
            const SizedBox(height: 18.0),
            transferBankItem(
              title: 'Rekening tujuan',
              value: widget.data.paymentTransferBankAccountNumber
                  .handlingEmptyString(),
            ),
            const SizedBox(height: 18.0),
            transferBankItem(
              title: 'Total transfer',
              value: AppCurrencyFormatter.format(
                double.parse(widget.data.grandTotal ?? '0'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget addressWidget(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.data.status == 'Dikirim'
                    ? 'Informasi Pengiriman'
                    : 'Alamat Pesanan',
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
              if (widget.data.status == 'Dikirim')
                BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const AppShimmer(
                        35,
                        60,
                        100,
                      );
                    }

                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          AppTransition.pushTransition(
                            DetailDeliveryPage(
                              widget.data.number.handlingEmptyString(),
                              state.deliveryStatus!,
                            ),
                            DetailDeliveryPage.routeSettings(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF5FF),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Text(
                          'Lacak',
                          style: appTextTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF2C98FF),
                              ),
                        ),
                      ),
                    );
                  },
                ),
              // Row(
              //   children: [
              //     Text(
              //       'No.',
              //       textAlign: TextAlign.start,
              //       style: appTextTheme(context).bodySmall?.copyWith(
              //             fontWeight: FontWeight.w400,
              //             color: AppColor.black[500],
              //           ),
              //     ),
              //     const SizedBox(width: 8.0),
              //     Text(
              //       widget.data.number.handlingEmptyString(),
              //       textAlign: TextAlign.start,
              //       style: appTextTheme(context).bodySmall?.copyWith(
              //             fontWeight: FontWeight.w700,
              //             color: AppColor.black,
              //           ),
              //     ),
              //     const SizedBox(width: 8.0),
              //     InkWell(
              //       onTap: () {
              //         Clipboard.setData(
              //           ClipboardData(
              //             text: widget.data.number.handlingEmptyString(),
              //           ),
              //         ).then((_) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             const SnackBar(
              //               content: Text('Nomor Pesanan berhasil disalin'),
              //             ),
              //           );
              //         });
              //       },
              //       child: Image.asset(
              //         AppAssets.copyIcon,
              //         width: 16,
              //         height: 16,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColor.neutral[200]!,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.primary[600],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    AppAssets.mapPinIcon,
                    width: 18,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.deliveryAddressTitle.handlingEmptyString(),
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.black,
                            ),
                      ),
                      Text(
                        widget.data.deliveryAddressName.handlingEmptyString(),
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColor.black[500],
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productItem(
    BuildContext context,
    OrderDetail data,
  ) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AppNetworkImage(
                data.itemImageUrl ?? '',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(width: 18.0),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.itemName ?? '-',
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6.0),
              Text(
                data.itemCategoryName ?? '-',
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(color: AppColor.neutral[400]),
              ),
              const SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.itemSellPrice != null
                        ? appConvertCurrency(double.parse(data.itemSellPrice!))
                        : '-',
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'x${data.qty}',
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget orderItems(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesanan Kamu',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 8.0),
          const AppDottedLine(),
          const SizedBox(height: 16.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.data.orderDetails?.length ?? 0,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: AppDottedLine(),
            ),
            itemBuilder: (context, index) {
              return productItem(
                context,
                widget.data.orderDetails![index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget rowText(
    BuildContext context,
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.black[500],
              ),
        ),
        Text(
          value,
          textAlign: TextAlign.end,
          style: appTextTheme(context).bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColor.black,
              ),
        ),
      ],
    );
  }

  Widget orderDetail(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pesanan',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 16.0),
          rowText(
            context,
            'No Pesanan',
            widget.data.number.handlingEmptyString(),
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            'Tanggal Pesanan',
            '${AppConvertDateTime().dmyName(widget.data.datetime ?? DateTime.now())} ${AppConvertDateTime().jm24(widget.data.datetime ?? DateTime.now())}',
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            'Atas Nama',
            widget.data.memberName.handlingEmptyString(),
          ),
        ],
      ),
    );
  }

  Widget feeDetail(BuildContext context) {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rincian Biaya',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 16.0),
          rowText(
            context,
            'Harga',
            appConvertCurrency(double.parse(widget.data.grandTotal ?? '0')),
          ),
          // const SizedBox(height: 12.0),
          // rowText(
          //   context,
          //   'Potongan Harga',
          //   'Rp 0',
          // ),
          const SizedBox(height: 16.0),
          const AppDottedLine(),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pembayaran',
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
              Text(
                appConvertCurrency(double.parse(widget.data.grandTotal ?? '0')),
                textAlign: TextAlign.end,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.accent,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentProof(void Function(void Function()) setModalState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            Text(
              'Unggah Bukti Bayar',
              style: appTextTheme(context).bodyMedium,
            ),
            Text(
              ' *',
              style:
                  appTextTheme(context).bodyMedium?.copyWith(color: Colors.red),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        AppPickImageCard(
          () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              builder: (bottomSheetContext) {
                return AppImagePickerMenu(
                  'Upload Gambar',
                  (type) async {
                    switch (type) {
                      case PhotoSource.camera:
                        final document = await pickDocumentImage(
                          bottomSheetContext,
                          ImageSource.camera,
                        );
                        if (document != null) {
                          await document.readAsBytes().then((image) {
                            setModalState(() {
                              listImage.add(image);
                            });
                            Navigator.of(bottomSheetContext).pop();
                          });
                        }
                        break;
                      case PhotoSource.gallery:
                        final document = await pickDocumentImage(
                          bottomSheetContext,
                          ImageSource.gallery,
                        );
                        if (document != null) {
                          await document.readAsBytes().then((image) {
                            setModalState(() {
                              listImage.add(image);
                            });
                            Navigator.of(bottomSheetContext).pop();
                          });
                        }
                        break;
                    }
                  },
                );
              },
            );
          },
          listImage: listImage,
          onTapImage: (value) {
            setState(() {
              listImage.removeAt(value);
            });
          },
        ),
        const SizedBox(height: 8.0),
        Text(
          'Unggah file .jpg, .jpeg, .png, .img, .pdf, .doc, ukuran maks 2MB',
          style: appTextTheme(context).labelLarge?.copyWith(
                color: AppColor.neutral[500],
              ),
        ),
      ],
    );
  }

  Widget noteTextField() {
    return AppValidatorTextField(
      controller: noteController,
      hintText: 'Masukan catatan',
      labelText: 'Catatan',
      maxLines: 3,
    );
  }

  Function() donePaymentShowModal(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (modalContext) {
          return StatefulBuilder(
            builder: (stateContext, setModalState) {
              return AppBottomSheet(
                'Bukti Pembayaran',
                height: MediaQuery.of(context).size.height * 0.7,
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    paymentProof(setModalState),
                    const SizedBox(height: 16),
                    noteTextField(),
                    const SizedBox(height: 36),
                    AppPrimaryFullButton(
                      'Konfirmasi',
                      () {
                        Navigator.of(context).pop();
                      },
                      height: 56,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        },
      );
    };
  }

  Widget button(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          if ((widget.data.status == 'Menunggu' ||
                  widget.data.status == 'Diproses' ||
                  widget.data.status == 'Dikirim') &&
              widget.data.paymentStatus == 'Belum Terbayar')
            AppPrimaryFullButton(
              'Saya Sudah Bayar',
              uploadPaymentProof(
                context,
                (file, notes) {
                  context.read<TransactionDetailCubit>().uploadPaymentProof(
                        widget.data.id ?? '0',
                        file,
                        notes,
                      );
                },
              ),
            ),
          const SizedBox(height: 16.0),
          if (widget.data.status == 'Menunggu')
            AppPrimaryOutlineFullButton(
              'Batalkan Pesanan',
              () {
                showDeleteBottomSheet(
                  context,
                  title: 'Batalkan pesanan',
                  descriptions: 'Yakin ingin membatalkan pesanan ini?',
                  onTapDelete: () {
                    context
                        .read<TransactionDetailCubit>()
                        .cancelOrder(widget.data.id ?? '0');
                    Navigator.of(context).pop();
                  },
                  buttonTitle: 'Iya, Batalkan',
                  cancelTitle: 'Tidak',
                );
              },
            ),
          const SizedBox(height: 16.0),
          if ((widget.data.status == 'Diproses' ||
                  widget.data.status == 'Dikirim') &&
              widget.data.paymentStatus == 'Pembayaran Selesai')
            AppPrimaryFullButton(
              'Selesaikan Pesanan',
              () {
                context
                    .read<TransactionDetailCubit>()
                    .completeTransaction(widget.data.id ?? '0');
              },
            ),
        ],
      ),
    );
  }

  Widget proofAttachment() {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bukti Pembayaran',
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () {
              if (widget.data.paymentProofImageUrl?.isNotEmpty ?? false) {
                showImageViewer(
                  context,
                  Image.network(widget.data.paymentProofImageUrl!).image,
                  immersive: false,
                  useSafeArea: true,
                  swipeDismissible: true,
                  doubleTapZoomable: true,
                  backgroundColor: Colors.black.withOpacity(0.7),
                );
              }
            },
            child: Image.network(
              widget.data.paymentProofImageUrl ?? '',
              height: MediaQuery.sizeOf(context).height * 0.25,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 100.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_outlined,
                          color: AppColor.red,
                          size: 28.0,
                        ),
                        SizedBox(height: 16.0),
                        Text('Bukti pembayaran tidak ditemukan'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 16.0),
        statusBar(context),
        const SizedBox(height: 16.0),
        paymentMethod(context),
        const SizedBox(height: 16.0),
        addressWidget(context),
        const SizedBox(height: 16.0),
        orderItems(context),
        const SizedBox(height: 16.0),
        orderDetail(context),
        const SizedBox(height: 16.0),
        feeDetail(context),
        const SizedBox(height: 16.0),
        if (widget.data.paymentStatus != 'Belum Terbayar') proofAttachment(),
        const SizedBox(height: 32.0),
        button(context),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
