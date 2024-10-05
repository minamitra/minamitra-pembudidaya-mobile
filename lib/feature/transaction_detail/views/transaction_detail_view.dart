import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pick_image_services/pick_image_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/adress_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TransactionDetailView extends StatefulWidget {
  final List<ProductsResponseData> listProduct;
  final List<int> listAmountItem;
  final Address address;
  final MethodPaymentData methodPayment;

  const TransactionDetailView(
    this.listProduct,
    this.listAmountItem,
    this.address,
    this.methodPayment, {
    super.key,
  });

  @override
  State<TransactionDetailView> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends State<TransactionDetailView> {
  final TextEditingController noteController = TextEditingController();
  List<Uint8List> listImage = [];

  Widget statusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.accent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Menunggu Konfirmasi Pesanan',
        textAlign: TextAlign.center,
        style: appTextTheme(context).bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColor.white,
            ),
      ),
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
                child: Image.asset(
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
                      widget.methodPayment.name,
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.black,
                          ),
                    ),
                    Text(
                      widget.methodPayment.description,
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
                'Alamat Pesanan',
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
              Row(
                children: [
                  Text(
                    'ID Pesanan',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.black[500],
                        ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '782784991',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                        ),
                  ),
                  const SizedBox(width: 8.0),
                  Image.asset(
                    AppAssets.copyIcon,
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                  )
                ],
              ),
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
                    color: AppColor.primary[900],
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
                        widget.address.title,
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColor.black,
                            ),
                      ),
                      Text(
                        widget.address.address,
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
    ProductsResponseData data,
    int amountItem,
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
                data.imageUrl ?? "",
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
                data.name ?? "-",
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6.0),
              Text(
                data.categoryName ?? "-",
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(color: AppColor.neutral[400]),
              ),
              const SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.sellPrice != null
                        ? appConvertCurrency(double.parse(data.sellPrice!))
                        : "-",
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "x$amountItem",
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        )
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
            itemCount: widget.listProduct.length,
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: AppDottedLine(),
            ),
            itemBuilder: (context, index) {
              return productItem(
                context,
                widget.listProduct[index],
                widget.listAmountItem[index],
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
            "No Pesanan",
            "XD-89100-B",
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            "Tanggal Pesanan",
            "15 Nov 2024, 16.08",
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            "Atas Nama",
            "John Doe",
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
            "Harga",
            "Rp 300.000",
          ),
          const SizedBox(height: 12.0),
          rowText(
            context,
            "Potongan Harga",
            "Rp 0",
          ),
          const SizedBox(height: 16.0),
          const AppDottedLine(),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Pembayaran",
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.black,
                    ),
              ),
              Text(
                "Rp 300.000",
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
              "Unggah Bukti Bayar",
              style: appTextTheme(context).bodyMedium,
            ),
            Text(
              " *",
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
                  "Upload Gambar",
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
          "Unggah file .jpg, .jpeg, .png, .img, .pdf, .doc, ukuran maks 2MB",
          style: appTextTheme(context).labelLarge?.copyWith(
                color: AppColor.neutral[500],
              ),
        )
      ],
    );
  }

  Widget noteTextField() {
    return AppValidatorTextField(
      controller: noteController,
      hintText: "Masukan catatan",
      labelText: "Catatan",
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
                "Bukti Pembayaran",
                height: MediaQuery.of(context).size.height * 0.7,
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    paymentProof(setModalState),
                    const SizedBox(height: 16),
                    noteTextField(),
                    const SizedBox(height: 36),
                    AppPrimaryFullButton(
                      "Konfirmasi",
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
          AppPrimaryFullButton(
            "Saya Sudah Bayar",
            donePaymentShowModal(context),
          ),
          const SizedBox(height: 16.0),
          AppPrimaryOutlineFullButton(
            "Batalkan Pesanan",
            () {
              Navigator.of(context).pop();
            },
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
        const SizedBox(height: 32.0),
        button(context),
        const SizedBox(height: 32.0),
      ],
    );
  }
}
