import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dotted_line.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/balance_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/repositories/member_address_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/logic/checkout_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/views/products_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CheckoutView extends StatefulWidget {
  final ProductsResponseData data;
  final bool isProductPromo;

  const CheckoutView(
    this.data,
    this.isProductPromo, {
    super.key,
  });

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget addressItem(
      int index,
      List<MemberAddressResponseData> listAddress,
      MemberAddressResponseData? selectedAddress,
      void Function() onTap,
      void Function(void Function()) setModalState,
    ) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Radio<MemberAddressResponseData>(
              value: listAddress[index],
              groupValue: selectedAddress,
              onChanged: (MemberAddressResponseData? value) {
                onTap();
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
                          listAddress[index].name.handlingEmptyString(),
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      (listAddress[index].isPrimaryBool ?? false)
                          ? Container(
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
                                'Utama',
                                textAlign: TextAlign.start,
                                style:
                                    appTextTheme(context).labelLarge?.copyWith(
                                          color: AppColor.secondary[900],
                                        ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      listAddress[index].address.handlingEmptyString(),
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

    Function() addressShowModal(
      BuildContext context,
      List<MemberAddressResponseData> listAddress,
      MemberAddressResponseData? selectedAddress,
    ) {
      return () {
        showModalBottomSheet(
          context: context,
          builder: (modalContext) {
            var selectedAddressTemp = selectedAddress;

            return StatefulBuilder(
              builder: (stateContext, setModalState) {
                return AppBottomSheet(
                  'Alamat Pengiriman',
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
                            return addressItem(
                              index,
                              listAddress,
                              selectedAddressTemp,
                              () {
                                setModalState(() {
                                  selectedAddressTemp = listAddress[index];
                                });
                              },
                              setModalState,
                            );
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
                                'Simpan',
                                () {
                                  if (selectedAddressTemp != null) {
                                    context
                                        .read<CheckoutCubit>()
                                        .onChangeSelectedAddress(
                                          selectedAddressTemp!,
                                        );
                                  }
                                  Navigator.of(context).pop();
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
      return BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return Container(
            color: AppColor.white,
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alamat Pengiriman',
                  style: appTextTheme(context)
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 18.0),
                state.status.isLoading
                    ? const AppShimmer(
                        85,
                        double.infinity,
                        8.0,
                      )
                    : InkWell(
                        onTap: addressShowModal(
                          context,
                          state.addressData,
                          state.selectedAddress,
                        ),
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
                                      state.selectedAddress?.name ??
                                          'Pilih Alamat Pengiriman',
                                      style: appTextTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      state.selectedAddress?.address ?? '-',
                                      style: appTextTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColor.neutral[500],
                                          ),
                                      maxLines: 2,
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
        },
      );
    }

    Widget productItem(ProductsResponseData data, int index) {
      return BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
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
                          data.imageUrl ?? '',
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
                          data.name ?? '-',
                          style: appTextTheme(context)
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          data.categoryName ?? '-',
                          style: appTextTheme(context)
                              .bodySmall
                              ?.copyWith(color: AppColor.neutral[400]),
                        ),
                        Text(
                          "Stok. ${(double.tryParse(data.stock ?? '0') ?? 0).toStringAsFixed(0)}",
                          style: appTextTheme(context)
                              .labelLarge
                              ?.copyWith(color: AppColor.neutral[400]),
                        ),
                        const SizedBox(height: 18.0),
                        Text(
                          data.sellPrice != null
                              ? appConvertCurrency(
                                  double.parse(data.sellPrice ?? '0'),
                                )
                              : '-',
                          style: appTextTheme(context)
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  index != 0 || state.listProduct.length > 1
                      ? InkWell(
                          onTap: () {
                            context.read<CheckoutCubit>().onRemoveItem(index);
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
                      if (state.listProduct[index].quantity! == 1) {
                        if (state.listProduct.length > 1) {
                          showDeleteBottomSheet(
                            context,
                            title: 'Hapus Item',
                            descriptions:
                                'Yakin ingin menghapus\nproduk ${state.listProduct[index].name} ?',
                            onTapDelete: () {
                              context.read<CheckoutCubit>().onRemoveItem(index);
                              Navigator.of(context).pop();
                            },
                          );
                          return;
                        } else {
                          return;
                        }
                      }

                      context.read<CheckoutCubit>().onDecreamentItem(index);
                    },
                    child: Icon(
                      Icons.remove_circle_outline_rounded,
                      color: AppColor.primary[600],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    state.listProduct[index].quantity.toString(),
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      if (state.listProduct[index].quantity! >
                          ((double.tryParse(
                                    state.listProduct[index].stock.toString(),
                                  ) ??
                                  1) -
                              1)) {
                        AppTopSnackBar(context)
                            .showDanger('Maaf stok tidak mencukupi');
                        return;
                      }

                      context.read<CheckoutCubit>().onIncreamentItem(index);
                    },
                    child: Icon(
                      Icons.add_circle_outline_rounded,
                      color: AppColor.primary[600],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    Widget checkoutItem() {
      return BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return Container(
            color: AppColor.white,
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Pesanan Kamu',
                        style: appTextTheme(context).bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    if (!widget.isProductPromo)
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                            AppTransition.pushTransition(
                              const ProductsPage(isPick: true),
                              ProductsPage.routeSettings(),
                            ),
                          )
                              .then(
                            (value) {
                              setState(
                                () {
                                  if (value != null) {
                                    int index = state.listProduct.indexWhere(
                                      (element) => element.id == value.id,
                                    );
                                    index == -1
                                        ? context
                                            .read<CheckoutCubit>()
                                            .onAddedProduct(value)
                                        : {
                                            if (state.listProduct[index]
                                                    .quantity! >
                                                ((double.tryParse(
                                                          state
                                                              .listProduct[
                                                                  index]
                                                              .stock
                                                              .toString(),
                                                        ) ??
                                                        1) -
                                                    1))
                                              {
                                                AppTopSnackBar(context)
                                                    .showDanger(
                                                  'Maaf stok tidak mencukupi',
                                                ),
                                              }
                                            else
                                              {
                                                context
                                                    .read<CheckoutCubit>()
                                                    .onIncreamentItem(index),
                                              },
                                          };
                                  }
                                },
                              );
                            },
                          );
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
                            '+ Tambah',
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
                state.status.isLoading
                    ? const AppShimmer(
                        125,
                        double.infinity,
                        8.0,
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.listProduct.length,
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.0),
                          child: AppDottedLine(),
                        ),
                        itemBuilder: (context, index) {
                          return productItem(
                            state.listProduct[index],
                            index,
                          );
                        },
                      ),
              ],
            ),
          );
        },
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
              'Detail Pesanan',
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
      return BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return Container(
            color: AppColor.white,
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rincian Biaya',
                  style: appTextTheme(context).bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16.0),
                rowText(
                  'Subtotal Produk',
                  appConvertCurrency(state.totalItemPrice),
                ),
                const SizedBox(height: 16.0),
                // rowText('Subtotal Pengiriman', 'Rp 20.000'),
                // const SizedBox(height: 16.0),
                // rowText('Total Diskom Pengiriman', 'Rp 0'),
                // const SizedBox(height: 16.0),
                // const AppDottedLine(),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Pembayaran',
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      appConvertCurrency(state.totalItemPrice),
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
        },
      );
    }

    Widget paymentItem(
      SelectedPayment item,
      SelectedPayment? selectedPayment,
      void Function() onTap,
      void Function(void Function()) setModalState,
    ) {
      return InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColor.primary[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: item.imageAsset != null
                  ? Image.asset(
                      item.imageAsset!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      item.imageUrl ?? '',
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
                    item.name.handlingEmptyString(),
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                        ),
                  ),
                  Text(
                    item.description != null
                        ? item.description!
                        : 'Transfer ke rekening ${item.name}',
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColor.black[400],
                        ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: item.name!,
              groupValue: selectedPayment?.name,
              onChanged: (value) {
                // setModalState(() {
                //   tempSelectedPaymentMethod = value;
                // });
                onTap();
              },
            ),
          ],
        ),
      );
    }

    Function() paymentShowModal(
      BuildContext context,
      SelectedPayment? selectedPayment,
      List<SelectedPayment> listRecommendationsPaymentData,
      List<SelectedPayment> listBankData,
      BalanceResponse? balanceResponse,
      double totalItemPrice,
    ) {
      return () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (modalContext) {
            SelectedPayment? tempSelectedPayment = selectedPayment;
            return StatefulBuilder(
              builder: (stateContext, setModalState) {
                log(tempSelectedPayment?.name.toString() ?? 'null');

                return AppBottomSheet(
                  'Metode Pembayaran',
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
                        itemCount: listRecommendationsPaymentData.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (_, index) {
                          return paymentItem(
                            listRecommendationsPaymentData[index],
                            tempSelectedPayment,
                            () {
                              setModalState(() {
                                tempSelectedPayment =
                                    listRecommendationsPaymentData[index];
                              });
                            },
                            setModalState,
                          );
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
                        itemCount: listBankData.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (_, index) {
                          return paymentItem(
                            listBankData[index],
                            tempSelectedPayment,
                            () {
                              setModalState(() {
                                tempSelectedPayment = listBankData[index];
                              });
                            },
                            setModalState,
                          );
                        },
                      ),
                      const SizedBox(height: 36),
                      AppPrimaryFullButton(
                        'Konfirmasi',
                        () {
                          if (tempSelectedPayment != null) {
                            if (tempSelectedPayment?.name == 'Dompet3M') {
                              if (totalItemPrice >
                                  (balanceResponse?.data?.totalSaldoRemaining ??
                                      0)) {
                                AppTopSnackBar(context)
                                    .showDanger('Saldo tidak mencukupi');
                              } else {
                                context
                                    .read<CheckoutCubit>()
                                    .onChangeSelectedPayment(
                                      tempSelectedPayment!,
                                    );
                              }
                            } else {
                              context
                                  .read<CheckoutCubit>()
                                  .onChangeSelectedPayment(
                                    tempSelectedPayment!,
                                  );
                            }
                          }
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

    Widget paymentMethod() {
      return BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const AppShimmer(
              120.0,
              double.infinity,
              0.0,
            );
          }
          return InkWell(
            onTap: paymentShowModal(
              context,
              state.selectedPayment,
              state.recommendationsPaymentData,
              state.bankData,
              state.balanceResponse,
              state.totalItemPrice,
            ),
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
                        'Metode Pembayaran',
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
                        child: state.selectedPayment?.imageUrl != null
                            ? AppNetworkImage(
                                state.selectedPayment?.imageUrl ?? '',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                state.selectedPayment?.imageAsset ??
                                    AppAssets.walletSquareIcon,
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
                              state.selectedPayment?.name ??
                                  'Pilih Metode Pembayaran',
                              textAlign: TextAlign.start,
                              style: appTextTheme(context).bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.black,
                                  ),
                            ),
                            Text(
                              state.selectedPayment == null
                                  ? '-'
                                  : state.selectedPayment!.description != null
                                      ? state.selectedPayment!.description!
                                      : 'Transfer ke rekening ${state.selectedPayment?.name}',
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
        },
      );
    }

    Widget buttonOrder() {
      return BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
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
                        'Total Pembayaran',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        appConvertCurrency(state.totalItemPrice),
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
                    'Buat Pesanan',
                    () {
                      if (state.selectedAddress == null) {
                        AppTopSnackBar(context).showDanger(
                          'Pilih alamat terlebih dahulu',
                        );
                        return;
                      }

                      if (state.selectedPayment == null) {
                        AppTopSnackBar(context).showDanger(
                          'Pilih metode pembayaran terlebih dahulu',
                        );
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (_) {
                          return AppDefaultDialog(
                            title: 'Proses Pesanan',
                            subTitle: 'Yakin ingin memproses pesanan?',
                            buttons: [
                              Expanded(
                                child: AppWhiteButton(
                                  'Batal',
                                  () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: AppPrimaryButton(
                                  'Proses',
                                  () {
                                    context
                                        .read<CheckoutCubit>()
                                        .processCheckout();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
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
            // detailOrder(),
            // const SizedBox(height: 18.0),
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
