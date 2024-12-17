import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_confirmation_payed/view/bill_payment_confirmation_payed_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/bill_payment_pay/logic/bill_payment_pay_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/checkout/repositories/selected_payment.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class BillPaymentPayView extends StatefulWidget {
  const BillPaymentPayView({super.key});

  @override
  State<BillPaymentPayView> createState() => _BillPaymentPayViewState();
}

class _BillPaymentPayViewState extends State<BillPaymentPayView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nominalController = TextEditingController();
  final FocusNode nominalFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(nominalFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    item.name?.handlingEmptyString() ?? '-',
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
      List<SelectedPayment> listPayment,
    ) {
      return () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (modalContext) {
            SelectedPayment? tempSelectedPayment = selectedPayment;
            return StatefulBuilder(
              builder: (stateContext, setModalState) {
                return AppBottomSheet(
                  'Metode Pembayaran',
                  height: MediaQuery.of(context).size.height * 0.52,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: listPayment.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (_, index) {
                              return paymentItem(
                                listPayment[index],
                                tempSelectedPayment,
                                () {
                                  setModalState(() {
                                    tempSelectedPayment = listPayment[index];
                                  });
                                },
                                setModalState,
                              );
                            },
                          ),
                        ),
                        AppPrimaryFullButton(
                          'Konfirmasi',
                          () {
                            if (tempSelectedPayment != null) {
                              context
                                  .read<BillPaymentPayCubit>()
                                  .onChangeSelectedPayment(
                                      tempSelectedPayment!);
                            }
                            Navigator.of(context).pop();
                          },
                          height: 56,
                        ),
                        const SizedBox(height: 18),
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metode Pembayaran',
            style: appTextTheme(context).bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 18.0),
          BlocBuilder<BillPaymentPayCubit, BillPaymentPayState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const AppShimmer(
                  75,
                  double.infinity,
                  8.0,
                );
              }

              return InkWell(
                onTap: paymentShowModal(
                  context,
                  state.selectedPayment,
                  state.payments,
                ),
                child: Row(
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
                    Text(
                      'Ganti',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColor.secondary[900],
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      );
    }

    Widget nominalField() {
      return AppValidatorTextField(
        controller: nominalController,
        focusNode: nominalFocus,
        labelText: 'Nominal Pembayaran',
        isMandatory: true,
        withUpperLabel: true,
        inputType: TextInputType.number,
        suffixConstraints: const BoxConstraints(),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text('Rp '),
        ),
        onEditingComplete: () {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Nominal harus diisi';
          }
          return null;
        },
        inputFormatters: [AppCurrencyFormatter.currency],
      );
    }

    Widget billInfo() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tagihan Tersedia',
            style: appTextTheme(context)
                .labelLarge
                ?.copyWith(color: AppColor.neutral[500]),
          ),
          Text(
            'Rp 12.500.000',
            style: appTextTheme(context)
                .titleSmall
                ?.copyWith(color: AppColor.primary[500]),
          ),
        ],
      );
    }

    Widget submitButton() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        color: AppColor.white,
        child: AppPrimaryFullButton(
          'Lanjutkan',
          () {
            if (formKey.currentState!.validate()) {
              if (context.read<BillPaymentPayCubit>().state.selectedPayment ==
                  null) {
                AppTopSnackBar(context)
                    .showDanger('Pilih metode pembayaran terlebih dahulu');
                return;
              }
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  BillPaymentConfirmationPayedPage(
                    context.read<BillPaymentPayCubit>().state.selectedPayment!,
                  ),
                  BillPaymentConfirmationPayedPage.routeSettings(),
                ),
              );
            }
          },
        ),
      );
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            color: AppColor.white,
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18.0),
                paymentMethod(),
                const SizedBox(height: 18.0),
                AppDividerSmall(),
                const SizedBox(height: 18.0),
                nominalField(),
                const SizedBox(height: 18.0),
                billInfo(),
                const SizedBox(height: 18.0),
              ],
            ),
          ),
          Expanded(child: Container(color: AppColor.neutral[100])),
          submitButton(),
        ],
      ),
    );
  }
}
