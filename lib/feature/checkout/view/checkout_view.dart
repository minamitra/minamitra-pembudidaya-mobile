import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> buyerLocation() {
      return [
        Text(
          "Alamat Pengeriman",
          style: appTextTheme(context)
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColor.neutral[200]!),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: AppColor.primary,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];
    }

    List<Widget> checkoutItemHeader() {
      return [
        Row(
          children: [
            Expanded(
              child: Text(
                "Pesanan Kamu",
                style: appTextTheme(context).bodySmall?.copyWith(
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
      ];
    }

    Widget listCheckoutItem() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: DottedLine(
            dashColor: AppColor.neutral[200]!,
          ),
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColor.neutral[400],
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Super Patin",
                          style: appTextTheme(context)
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          "Pakan",
                          style: appTextTheme(context)
                              .bodySmall
                              ?.copyWith(color: AppColor.neutral[400]),
                        ),
                        const SizedBox(height: 18.0),
                        Text(
                          "Rp 90.000",
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
                  const Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                  ),
                  const Expanded(child: SizedBox()),
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
        },
      );
    }

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(18.0),
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            ...buyerLocation(),
            const SizedBox(height: 18.0),
            ...checkoutItemHeader(),
            listCheckoutItem(),
          ],
        ),
      ],
    );
  }
}
