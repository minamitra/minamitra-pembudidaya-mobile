import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/adress_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/entities/method_payment_data.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int? selectedPaymentMethod;
  int? selectedAddress;

  @override
  Widget build(BuildContext context) {
    Widget addressItem(
        int index, void Function(void Function()) setModalState) {
      return InkWell(
        onTap: () {
          setModalState(() {
            selectedAddress = index;
          });
        },
        child: Row(
          children: [
            Radio<int>(
              value: index,
              groupValue: selectedAddress,
              onChanged: (int? value) {
                setModalState(() {
                  selectedAddress = value;
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
                  "Metode Pembayaran",
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
                                () {},
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
                            "Rumah 1",
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "806 George Isle, Port Andreaneworth 22495-6645",
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

    Column productItem() {
      return Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    AppAssets.product1Image,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
                      "Pakan Siap Cetak (PSC) Mina Mitra Mandirin",
                      style: appTextTheme(context)
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      "Pakan Ikan",
                      style: appTextTheme(context)
                          .bodySmall
                          ?.copyWith(color: AppColor.neutral[400]),
                    ),
                    const SizedBox(height: 18.0),
                    Text(
                      "Rp 190.000",
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
              Image.asset(
                AppAssets.trashIcon,
                width: 24,
                color: AppColor.red,
              ),
              const Spacer(),
              Icon(
                Icons.remove_circle_outline_rounded,
                color: AppColor.primary[600],
              ),
              const SizedBox(width: 8.0),
              Text(
                "1",
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8.0),
              Icon(
                Icons.add_circle_outline_rounded,
                color: AppColor.primary[600],
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
                  onTap: () {},
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
              itemCount: 2,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: AppDottedLine(),
              ),
              itemBuilder: (context, index) {
                return productItem();
              },
            )
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

    Function() paymentShowModal(BuildContext context) {
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
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.black,
                                              ),
                                        ),
                                        Text(
                                          listMethodPayment[index].description,
                                          textAlign: TextAlign.start,
                                          style: appTextTheme(context)
                                              .bodySmall
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.primary[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Image.asset(
                      AppAssets.walletIcon,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Plafon",
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              ),
                        ),
                        Text(
                          "Bayar menggunakan plafon",
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
                  Navigator.of(context).push(AppTransition.pushTransition(
                    const TransactionDetailPage(),
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
