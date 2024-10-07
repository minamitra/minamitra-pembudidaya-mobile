import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class QrScanSummaryView extends StatefulWidget {
  const QrScanSummaryView({super.key});

  @override
  State<QrScanSummaryView> createState() => _QrScanSummaryViewState();
}

class _QrScanSummaryViewState extends State<QrScanSummaryView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nominalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget transaction() {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              decoration: BoxDecoration(
                color: AppColor.primary[600],
                shape: BoxShape.circle,
              ),
              child: Image.asset(AppAssets.newLogoWhiteIcon),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Amanda Amanata",
              style: appTextTheme(context)
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            Text(
              "Dompet 3M",
              style: appTextTheme(context).labelLarge,
            ),
            const SizedBox(height: 18.0),
            AppValidatorTextField(
              controller: nominalController,
              labelText: "Nominal Transaksi",
              isMandatory: true,
              withUpperLabel: true,
              inputType: TextInputType.number,
              suffixConstraints: const BoxConstraints(),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text("Rp "),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Nominal harus diisi";
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    Widget originAccount() {
      return Container(
        color: AppColor.neutral[100],
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),
            Text(
              "Rekening Sumber",
              style: appTextTheme(context).labelLarge?.copyWith(
                    color: AppColor.neutral[500],
                  ),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 14.0,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: AppColor.white,
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                  )),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.walletSquareIcon,
                    width: 36.0,
                    height: 36.0,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rp 12.500.000",
                          style: appTextTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Saldo Dompet3M",
                          style: appTextTheme(context).labelLarge,
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

    Widget button() {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: AppPrimaryFullButton(
          "Lanjutkan",
          () {
            showModalBottomSheet(
              context: context,
              builder: (bottomSheetContext) {
                Widget transactionItem(
                  String title,
                  String subTitle,
                ) {
                  return Row(
                    children: [
                      Container(
                        width: 42.0,
                        height: 42.0,
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        decoration: BoxDecoration(
                          color: AppColor.primary[600],
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(AppAssets.newLogoWhiteIcon),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: appTextTheme(context).titleSmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              subTitle,
                              style: appTextTheme(context).labelLarge?.copyWith(
                                    color: AppColor.neutral[500],
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return AppBottomSheet(
                  "Konfirmasi Transafer",
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              transactionItem("Amanda Amanata", "Sumber"),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  Icons.keyboard_double_arrow_down_rounded,
                                  color: AppColor.neutralBlueGrey[400],
                                ),
                              ),
                              transactionItem("Koperasi 3M", "Penerima"),
                              const SizedBox(height: 18.0),
                              AppDividerSmall(),
                              const SizedBox(height: 18.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Nominal Transfer",
                                      style: appTextTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                            color: AppColor.neutral[500],
                                          ),
                                    ),
                                  ),
                                  Text(
                                    "Rp 12.500.000",
                                    style: appTextTheme(context)
                                        .bodySmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18.0),
                              AppDividerSmall(),
                              const SizedBox(height: 18.0),
                              Text(
                                "Rekening Sumber",
                                style:
                                    appTextTheme(context).labelLarge?.copyWith(
                                          color: AppColor.neutral[500],
                                        ),
                              ),
                              const SizedBox(height: 12.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                  vertical: 14.0,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: AppColor.white,
                                    border: Border.all(
                                      color: const Color(0xFFE5E7EB),
                                    )),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      AppAssets.walletSquareIcon,
                                      width: 36.0,
                                      height: 36.0,
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rp 12.500.000",
                                            style: appTextTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            "Saldo Dompet3M",
                                            style: appTextTheme(context)
                                                .labelLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppPrimaryFullButton(
                          "Bayar",
                          () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  height: MediaQuery.sizeOf(context).height * 0.75,
                );
              },
            );
          },
        ),
      );
    }

    return Column(
      children: [
        transaction(),
        Expanded(child: originAccount()),
        button(),
      ],
    );
  }
}
