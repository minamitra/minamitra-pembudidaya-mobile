import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_exchange_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_mission_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class PointExchange extends StatefulWidget {
  const PointExchange({super.key});

  @override
  State<PointExchange> createState() => _PointExchangeState();
}

class _PointExchangeState extends State<PointExchange> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController exchangeTypeController = TextEditingController();
  final TextEditingController customExchangeValueController =
      TextEditingController();

  List<String> exchangeType = [
    'Konversi Saldo',
    'Tarik Tunai',
  ];

  List<String> tocPoint = [
    'Untuk dapat melakukan penukaran poin, minimal perlu mencapai level gold atau 3000 poin',
    '1 Poin = Rp 100',
    'Minimal penukaran poin ke saldo atau tarik tunai adalah 250 poin atau Rp 25,000',
    'Maksimal penukaran poin ke saldo atau tarik tunai adalah 10,000 poin Rp 1,000,000',
    'Akumulasi penukaran poin ke saldo atau tarik tunai adalah 10,000 poin atau Rp 1,000,000 per hari',
  ];

  @override
  Widget build(BuildContext context) {
    Widget typeExchangeItem(String exchangeTypeName) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: exchangeTypeName == exchangeTypeController.text
                ? AppColor.primary[500]!
                : AppColor.neutral[200]!,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
          color: exchangeTypeName == exchangeTypeController.text
              ? AppColor.primary[50]
              : AppColor.white,
        ),
        child: RadioListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            exchangeTypeName,
            style: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[600],
                ),
          ),
          value: exchangeTypeName,
          groupValue: exchangeTypeController.text,
          onChanged: (value) {
            setState(() {
              exchangeTypeController.text = value.toString();
            });
          },
        ),
      );
    }

    Widget typeExchange() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tukar Poin',
            style: appTextTheme(context)
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 18.0),
          typeExchangeItem(exchangeType[0]),
          const SizedBox(height: 12.0),
          typeExchangeItem(exchangeType[1]),
        ],
      );
    }

    Widget exchangeGridItem({
      required bool isActive,
      required String title,
      required String value,
      required Function() onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: isActive ? AppColor.primary[50] : AppColor.white,
            border: Border.all(
              color: isActive ? AppColor.primary[500]! : AppColor.neutral[300]!,
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: appTextTheme(context).titleSmall?.copyWith(
                      color: isActive
                          ? AppColor.primary[400]
                          : AppColor.neutral[400],
                    ),
              ),
              const SizedBox(height: 10.0),
              Text(
                value,
                style: appTextTheme(context)
                    .titleMedium
                    ?.copyWith(color: AppColor.primary[500]),
              ),
            ],
          ),
        ),
      );
    }

    Widget exchangeValue() {
      return Column(
        children: [
          Row(
            children: [
              Text(
                'Nilai Penukaran',
                style: appTextTheme(context)
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (bottomSheetContext) {
                      return AppBottomSheet(
                        'Ketentuan Penukaran Point',
                        ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          children: [
                            ...List.generate(
                              tocPoint.length,
                              (index) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 9.0),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Icon(
                                            Icons.circle,
                                            color: Colors.black,
                                            size: 8.0,
                                          ),
                                        ),
                                        const SizedBox(width: 12.0),
                                        Expanded(
                                          child: Text(
                                            tocPoint[index],
                                            style:
                                                appTextTheme(context).bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 9.0),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        height: MediaQuery.sizeOf(context).height * 0.6,
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.help,
                  color: AppColor.primary[500],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          BlocBuilder<PointV2Cubit, PointV2State>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: exchangeGridItem(
                      isActive: state.selectedGridExchange == 250000,
                      title: '250 Poin',
                      value: 'Rp 25.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(250000);
                      },
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: exchangeGridItem(
                      isActive: state.selectedGridExchange == 500000,
                      title: '500 Poin',
                      value: 'Rp 50.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(500000);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18.0),
          BlocBuilder<PointV2Cubit, PointV2State>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: exchangeGridItem(
                      isActive: state.selectedGridExchange == 1000000,
                      title: '1000 Poin',
                      value: 'Rp 100.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(1000000);
                      },
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: exchangeGridItem(
                      isActive: state.selectedGridExchange == 2000000,
                      title: '2000 Poin',
                      value: 'Rp 200.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(2000000);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      );
    }

    Widget customExchangeValue() {
      return BlocBuilder<PointV2Cubit, PointV2State>(
        builder: (context, state) {
          return AppAnimatedSize(
            isShow: state.selectedGridExchange == -1,
            child: AppValidatorTextField(
              controller: customExchangeValueController,
              hintText: '0',
              labelText: 'Jumlah lainnya',
              inputType: TextInputType.phone,
              isMandatory: true,
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return null;
                }
                return null;
              },
              suffixConstraints: const BoxConstraints(),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  'Rp ',
                  style: appTextTheme(context).bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              inputFormatters: [AppCurrencyFormatter.currency],
            ),
          );
        },
      );
    }

    Widget buttonExchange() {
      return BlocBuilder<PointV2Cubit, PointV2State>(
        builder: (context, state) {
          return BlocBuilder<PointMissionV2Cubit, PointMissionV2State>(
            builder: (context, missionState) {
              return missionState.status.isLoading
                  ? const AppShimmer(
                      55.0,
                      double.infinity,
                      8.0,
                    )
                  : AppPrimaryFullButton(
                      'Submit',
                      () {
                        if (exchangeTypeController.text.isEmpty) {
                          AppTopSnackBar(context)
                              .showInfo('Pilih tipe penukaran');
                          return;
                        }
                        if (formKey.currentState!.validate()) {
                          if (state.selectedGridExchange == -1) {
                            // Custom Nominal
                            // int.parse(priceController.text.unFormatedCurrency())
                            if (int.parse(
                                  customExchangeValueController.text
                                      .unFormatedCurrency(),
                                ) <
                                1000) {
                              AppTopSnackBar(context)
                                  .showInfo('Minimal penukaran Rp 1.000');
                              return;
                            }
                            if (((missionState.pointBalance?.data?.totalPoin ??
                                        0) *
                                    100) <
                                (int.parse(
                                      customExchangeValueController.text
                                          .unFormatedCurrency(),
                                    ) /
                                    100)) {
                              AppTopSnackBar(context)
                                  .showInfo('Poin tidak mencukupi');
                              return;
                            }
                            context.read<PointExchangeCubit>().exchangePoint(
                                  type: exchangeTypeController.text,
                                  point: int.parse(
                                        customExchangeValueController.text
                                            .unFormatedCurrency(),
                                      ) ~/
                                      100,
                                  nominalRP: int.parse(
                                    customExchangeValueController.text
                                        .unFormatedCurrency(),
                                  ),
                                );
                          } else {
                            // From Grid
                            if (((missionState.pointBalance?.data?.totalPoin ??
                                        0) *
                                    100) <
                                state.selectedGridExchange) {
                              AppTopSnackBar(context)
                                  .showInfo('Poin tidak mencukupi');
                              return;
                            }
                            context.read<PointExchangeCubit>().exchangePoint(
                                  type: exchangeTypeController.text,
                                  point: state.selectedGridExchange ~/ 100,
                                  nominalRP: state.selectedGridExchange,
                                );
                          }
                        }
                        null;
                      },
                    );
            },
          );
        },
      );
    }

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            typeExchange(),
            const SizedBox(height: 18.0),
            exchangeValue(),
            const SizedBox(height: 18.0),
            customExchangeValue(),
            const SizedBox(height: 32.0),
            buttonExchange(),
            const SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }
}
