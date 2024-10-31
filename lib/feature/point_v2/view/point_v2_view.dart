import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_money_formatter.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/view/history_point_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/name_icon_entity.dart';
import 'package:minamitra_pembudidaya_mobile/feature/point_v2/logic/point_v2_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PointV2View extends StatefulWidget {
  const PointV2View({super.key});

  @override
  State<PointV2View> createState() => _PointV2ViewState();
}

class _PointV2ViewState extends State<PointV2View> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController exchangeTypeController = TextEditingController();
  final TextEditingController customExchangeValueController =
      TextEditingController();

  List<NameIconEntity> listLevel = [
    NameIconEntity(
      '200',
      AppAssets.silverIcon,
    ),
    NameIconEntity(
      '400',
      AppAssets.goldIcon,
    ),
    NameIconEntity(
      '600',
      AppAssets.platinumIcon,
    ),
    NameIconEntity(
      '800',
      AppAssets.diamondIcon,
    ),
  ];

  List<String> exchangeType = [
    'Konversi Saldo',
    'Tarik Tunai',
  ];

  List<NameIconEntity> listPointInfo = [
    NameIconEntity(
      'Silver',
      AppAssets.silverIcon,
      description: 'Kumpulkan 1000 poin untuk mendapatkan lencana silver.',
    ),
    NameIconEntity(
      'Gold',
      AppAssets.goldIcon,
      description: 'Kumpulkan 3000 poin untuk mendapatkan lencana gold.',
    ),
    NameIconEntity(
      'Platinum',
      AppAssets.platinumIcon,
      description: 'Kumpulkan 7000 poin untuk mendapatkan lencana platinum.',
    ),
    NameIconEntity(
      'Diamond',
      AppAssets.diamondIcon,
      description: 'Kumpulkan 10.000 poin untuk mendapatkan lencana diamond.',
    ),
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
    Widget headerAppBar() {
      return Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: AppColor.white,
            ),
          ),
          const SizedBox(width: 18.0),
          Expanded(
            child: Text(
              'Infromasi Poin',
              style: appTextTheme(context)
                  .headlineSmall
                  ?.copyWith(color: AppColor.white),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                const HistoryPointPage(),
                HistoryPointPage.route,
              ),);
            },
            child: Text(
              'Riwayat',
              style: appTextTheme(context)
                  .titleMedium
                  ?.copyWith(color: AppColor.white),
            ),
          ),
          const SizedBox(width: 8.0),
          InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                const HistoryPointPage(),
                HistoryPointPage.route,
              ),);
            },
            child: const Icon(
              Icons.history,
              color: AppColor.white,
            ),
          ),
        ],
      );
    }

    Widget headerPointView() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.platinumIcon,
              height: 64.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12.0),
            Text(
              '7100 Poin',
              style: appTextTheme(context).titleMedium?.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Platinum',
              style: appTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: AppColor.white),
            ),
          ],
        ),
      );
    }

    Widget headerPointInfo() {
      return InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (bottomSheetContext) {
              return AppBottomSheet(
                'List Member Level',
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    ...List.generate(
                      listPointInfo.length,
                      (index) {
                        return Column(
                          children: [
                            const SizedBox(height: 16.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  listPointInfo[index].icon,
                                  height: 28.0,
                                  width: 28.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listPointInfo[index].name,
                                        style: appTextTheme(context)
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w700,),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(
                                        listPointInfo[index].description ?? '-',
                                        style: appTextTheme(context)
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColor.neutral[400],),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            AppDividerSmall(),
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
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: AppColor.primary[500],
            border: Border.all(
              color: AppColor.primary[300]!,
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      listLevel.length,
                      (index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              listLevel[index].icon,
                              height: 28.0,
                              width: 28.0,
                              fit: BoxFit.cover,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 16.0,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      LinearPercentIndicator(
                        // padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        animation: true,
                        lineHeight: 8.0,
                        animationDuration: 1000,
                        percent: 0.4,
                        barRadius: const Radius.circular(8.0),
                        progressColor: AppColor.accent[900],
                        backgroundColor: AppColor.neutral[100],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            listLevel.length,
                            (index) {
                              return Image.asset(
                                AppAssets.circleActiveIcon,
                                width: 16.0,
                                height: 16.0,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      listLevel.length,
                      (index) {
                        return Text(
                          listLevel[index].name,
                          style: appTextTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget header() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        // height: MediaQuery.sizeOf(context).height * 0.35,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00317E),
              Color(0xFF0059E4),
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18.0),
            bottomRight: Radius.circular(18.0),
          ),
          image: DecorationImage(
            image: AssetImage(AppAssets.pointBackgroundv2Image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            headerAppBar(),
            headerPointView(),
            headerPointInfo(),
          ],
        ),
      );
    }

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
                color:
                    isActive ? AppColor.primary[500]! : AppColor.neutral[300]!,),
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
                      isActive: state.selectedGridExchange == 0,
                      title: '250 Poin',
                      value: 'Rp 25.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(0);
                      },
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: exchangeGridItem(
                      isActive: state.selectedGridExchange == 1,
                      title: '500 Poin',
                      value: 'Rp 50.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(1);
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
                      isActive: state.selectedGridExchange == 2,
                      title: '1000 Poin',
                      value: 'Rp 100.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(2);
                      },
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: exchangeGridItem(
                      isActive: state.selectedGridExchange == 3,
                      title: '2000 Poin',
                      value: 'Rp 200.000',
                      onTap: () {
                        context
                            .read<PointV2Cubit>()
                            .onChangeGridExchangeValue(3);
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
      return AppValidatorTextField(
        controller: customExchangeValueController,
        hintText: '0',
        labelText: 'Kustom Nominal',
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
      );
    }

    Widget buttonExchange() {
      return AppPrimaryFullButton(
        'Submit',
        () {
          if (formKey.currentState!.validate()) {
            context.read<PointV2Cubit>().onSubmitExchange();
          }
          null;
        },
      );
    }

    Widget form() {
      return Padding(
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
      );
    }

    return Form(
      key: formKey,
      child: ListView(
        children: [
          header(),
          const SizedBox(height: 18.0),
          form(),
        ],
      ),
    );
  }
}
