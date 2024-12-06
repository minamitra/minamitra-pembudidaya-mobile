import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/voucher_detail/view/voucher_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class VoucherView extends StatefulWidget {
  const VoucherView({super.key});

  @override
  State<VoucherView> createState() => _VoucherViewState();
}

class _VoucherViewState extends State<VoucherView> {
  @override
  Widget build(BuildContext context) {
    Widget titleSection(String title) {
      return Text(
        title,
        textAlign: TextAlign.start,
        style: appTextTheme(context).bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
      );
    }

    Widget voucherCard({
      required String image,
      required String title,
      required String description,
      required bool isAvailable,
    }) {
      return Row(
        children: [
          Image.asset(
            image,
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.neutral[200]!,
                    width: 1,
                  ),
                  right: BorderSide(
                    color: AppColor.neutral[200]!,
                    width: 1,
                  ),
                  top: BorderSide(
                    color: AppColor.neutral[200]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.black,
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          description,
                          textAlign: TextAlign.start,
                          style: appTextTheme(context)
                              .labelSmall
                              ?.copyWith(color: AppColor.neutral[500]),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'S&K Berlaku',
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.primary[500],
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(
                        color: isAvailable
                            ? AppColor.primary[500]!
                            : AppColor.neutral[300]!,
                      ),
                    ),
                    child: Text(
                      isAvailable ? 'Pakai' : 'Habis',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).labelLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: isAvailable
                                ? AppColor.primary[500]
                                : AppColor.neutral[300],
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget listVoucherDiscount() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        separatorBuilder: (context, index) => const SizedBox(height: 12.0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const VoucherDetailPage(),
                  VoucherDetailPage.routeSettings(),
                ),
              );
            },
            child: voucherCard(
              image: AppAssets.voucherTicketCardImage,
              title: 'Diskon 50%',
              description: 'Berlaku Hingga: 02 Des 2024',
              isAvailable: index > 2 ? false : true,
            ),
          );
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        titleSection('Voucher Spesial'),
        const SizedBox(height: 18.0),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              AppTransition.pushTransition(
                const VoucherDetailPage(),
                VoucherDetailPage.routeSettings(),
              ),
            );
          },
          child: voucherCard(
            image: AppAssets.voucherBoxCardImage,
            title: 'Black Friday 50% Off',
            description: 'Berlaku Hingga: 02 Des 2024',
            isAvailable: true,
          ),
        ),
        const SizedBox(height: 18.0),
        titleSection('Voucher Diskon'),
        const SizedBox(height: 18.0),
        listVoucherDiscount(),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
