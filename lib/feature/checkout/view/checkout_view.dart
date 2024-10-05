import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/adress_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/views/products_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CheckoutView extends StatefulWidget {
  final ProductsResponseData data;

  const CheckoutView(this.data, {super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final TextEditingController noteController = TextEditingController();
  MethodPaymentData? selectedPaymentMethod;
  MethodPaymentData? tempSelectedPaymentMethod;
  Address? selectedAddress;
  Address? tempSelectedAddress;
  List<ProductsResponseData> listProduct = [];
  List<int> listAmountItem = [];

  @override
  void initState() {
    super.initState();
    listProduct.add(widget.data);
    listAmountItem.add(1);
  }

  @override
  Widget build(BuildContext context) {
    Widget addressItem(
      int index,
      void Function(void Function()) setModalState,
    ) {
      return InkWell(
        onTap: () {
          setModalState(() {
            tempSelectedAddress = listAddress[index];
          });
        },
        child: Row(
          children: [
            Radio<Address>(
              value: listAddress[index],
              groupValue: tempSelectedAddress,
              onChanged: (Address? value) {
                setModalState(() {
                  tempSelectedAddress = value;
                });
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          listAddress[index].title,
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      listAddress[index].type == null
                          ? const SizedBox()
                          : Container(
                              margin: const EdgeInsets.only(left: 16),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColor.secondary[50],
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColor.secondary[900]!,
                                ),
                              ),
                              child: Text(
                                listAddress[index].type!,
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).labelLarge?.copyWith(
                                          color: AppColor.secondary[900],
                                        ),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      listAddress[index].address,
                      textAlign: TextAlign.justify,
                      style: appTextTheme(context).bodySmall?.copyWith(
                            color: AppColor.neutral[500],
                          ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Function() addressShowModal(BuildContext context) {
      return () {
        showModalBottomSheet(
          context: context,
          builder: (modalContext) {
            return StatefulBuilder(
              builder: (stateContext, setModalState) {
                return AppBottomSheet(
                  "Alamat Pengiriman",
                  height: MediaQuery.of(context).size.height * 0.7,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        ListView.separated(
                          padding: const EdgeInsets.only(bottom: 98),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: listAddress.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return addressItem(index, setModalState);
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                border: Border(
                                  top: BorderSide(
                                    color: AppColor.neutral[200]!,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: AppPrimaryFullButton(
                                "Simpan",
                                () {
                                  if (tempSelectedAddress != null) {
                                    setState(() {
                                      selectedAddress = tempSelectedAddress;
                                    });
                                    Navigator.of(context).pop();
                                  }
                                },
                                height: 56,
                              ),
                            ),
                          ],
                        ),
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

    Widget buyerLocation() {
      return Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Alamat Pengiriman",
              style: appTextTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18.0),
            InkWell(
              onTap: addressShowModal(context),
              child: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: AppColor.neutral[200]!),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColor.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        AppAssets.mapPinIcon,
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedAddress?.title ?? "Alamat Pengiriman",
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            selectedAddress?.address ?? "-",
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  color: AppColor.neutral[500],
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Column productItem(ProductsResponseData data, int index) {
      return Column(
        children: [
          Row(
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
                    Text(
                      data.sellPrice != null
                          ? appConvertCurrency(double.parse(data.sellPrice!))
                          : "-",
                      style: appTextTheme(context)
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              index != 0 || listProduct.length > 1
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          listProduct.removeAt(index);
                          listAmountItem.removeAt(index);
                        });
                      },
                      child: Image.asset(
                        AppAssets.trashIcon,
                        width: 24,
                        color: AppColor.red,
                      ),
                    )
                  : const SizedBox(),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (listAmountItem[index] > 1) {
                    setState(() {
                      listAmountItem[index]--;
                    });
                  }
                },
                child: Icon(
                  Icons.remove_circle_outline_rounded,
                  color: AppColor.primary[600],
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                listAmountItem[index].toString(),
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () {
                  setState(() {
                    listAmountItem[index]++;
                  });
                },
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  color: AppColor.primary[600],
                ),
              )
            ],
          ),
        ],
      );
    }

    Widget checkoutItem() {
      return Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Pesanan Kamu",
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(AppTransition.pushTransition(
                      const ProductsPage(isPick: true),
                      ProductsPage.routeSettings(),
                    ))
                        .then((value) {
                      setState(() {
                        listProduct.add(value as ProductsResponseData);
                        listAmountItem.add(1);
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primary[600],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(
                      "+ Tambah",
                      style: appTextTheme(context).bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            Divider(
              color: AppColor.neutral[200],
              thickness: 1.0,
              height: 0.0,
            ),
            const SizedBox(height: 18.0),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listProduct.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: AppDottedLine(),
              ),
              itemBuilder: (context, index) {
                return productItem(listProduct[index], index);
              },
            ),
          ],
        ),
      );
    }

    Widget rowText(String title, String value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: appTextTheme(context).titleSmall!,
          ),
        ],
      );
    }

    Widget detailOrder() {
      return Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detail Pesanan",
              style: appTextTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 16.0),
            rowText('No Pesanan', 'XD-89100-B'),
            const SizedBox(height: 16.0),
            rowText('Tanggal Pesanan', '15 Nov 2019, 16:08'),
          ],
        ),
      );
    }

    Widget detailPayment() {
      return Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rincian Biaya",
              style: appTextTheme(context).bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 16.0),
            rowText('Subtotal Produk', 'Rp 280.000'),
            const SizedBox(height: 16.0),
            rowText('Subtotal Pengiriman', 'Rp 20.000'),
            const SizedBox(height: 16.0),
            rowText('Total Diskom Pengiriman', 'Rp 0'),
            const SizedBox(height: 16.0),
            const AppDottedLine(),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pembayaran",
                  style: appTextTheme(context).bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  "Rp 300.000",
                  style: appTextTheme(context).bodyMedium?.copyWith(
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

    Widget paymentItem(
      MethodPaymentData data,
      void Function(void Function()) setModalState,
    ) {
      return InkWell(
        onTap: () {
          setModalState(() {
            tempSelectedPaymentMethod = data;
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
                data.icon,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                  ),
                  Text(
                    data.description,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.black[400],
                        ),
                  ),
                ],
              ),
            ),
            Radio<MethodPaymentData>(
              value: data,
              groupValue: tempSelectedPaymentMethod,
              onChanged: (value) {
                setModalState(() {
                  tempSelectedPaymentMethod = value;
                });
              },
            ),
          ],
        ),
      );
    }

    Function() paymentShowModal(BuildContext context) {
      return () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (modalContext) {
            return StatefulBuilder(
              builder: (stateContext, setModalState) {
                return AppBottomSheet(
                  "Metode Pembayaran",
                  height: MediaQuery.of(context).size.height * 0.7,
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      Text(
                        'Rekomendasi',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
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
                          return paymentItem(
                              listMethodPayment[index], setModalState);
                        },
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Transfer Bank',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
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
                          return paymentItem(
                              listMethodBank[index], setModalState);
                        },
                      ),
                      const SizedBox(height: 36),
                      AppPrimaryFullButton(
                        "Konfirmasi",
                        () {
                          if (tempSelectedPaymentMethod != null) {
                            setState(() {
                              selectedPaymentMethod = tempSelectedPaymentMethod;
                            });
                            Navigator.of(context).pop();
                          }
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

    Widget paymentMethod() {
      return InkWell(
        onTap: paymentShowModal(context),
        child: Container(
          color: AppColor.white,
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Metode Pembayaran",
                    style: appTextTheme(context).bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.neutral[400],
                    size: 16.0,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      selectedPaymentMethod?.icon ?? AppAssets.walletSquareIcon,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedPaymentMethod?.name ??
                              "Pilih Metode Pembayaran",
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              ),
                        ),
                        Text(
                          selectedPaymentMethod?.description ?? "-",
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
        ),
      );
    }

    Widget buttonOrder() {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(
            top: BorderSide(
              color: AppColor.neutral[200]!,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total Pembayaran",
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "Rp 300.000",
                    style: appTextTheme(context).bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.accent,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AppPrimaryFullButton(
                "Buat Pesanan",
                () {
                  if (selectedAddress == null ||
                      selectedPaymentMethod == null) {
                    AppTopSnackBar(context).showDanger(
                        "Pilih alamat dan metode pembayaran terlebih dahulu");
                    return;
                  }
                  Navigator.of(context).push(AppTransition.pushTransition(
                    TransactionDetailPage(
                      listProduct,
                      listAmountItem,
                      selectedAddress!,
                      selectedPaymentMethod!,
                    ),
                    TransactionDetailPage.routeSettings(),
                  ));
                },
              ),
            ),
          ],
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            buyerLocation(),
            const SizedBox(height: 18.0),
            checkoutItem(),
            const SizedBox(height: 18.0),
            detailOrder(),
            const SizedBox(height: 18.0),
            detailPayment(),
            const SizedBox(height: 18.0),
            paymentMethod(),
            const SizedBox(height: 98.0),
          ],
        ),
        buttonOrder(),
      ],
    );
  }
}
