import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddressMemberView extends StatefulWidget {
  const AddressMemberView({super.key});

  @override
  State<AddressMemberView> createState() => _AddressMemberViewState();
}

class _AddressMemberViewState extends State<AddressMemberView> {
  @override
  Widget build(BuildContext context) {
    Widget addressCard() {
      return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 18.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Rumah",
                          style: appTextTheme(context)
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Amanda Pranata (081234567890)",
                          style: appTextTheme(context).bodySmall?.copyWith(
                                color: AppColor.neutral[500],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.secondary[50],
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: AppColor.secondary[900]!),
                    ),
                    child: Text(
                      "Utama",
                      style: appTextTheme(context).labelLarge?.copyWith(
                            color: AppColor.secondary[900],
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                "M8RX+XC, Ps. Martapura, Kec. Martapura, Kabupaten Ogan Komering Ulu Timur, Sumatera Selatan 32313",
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColor.neutral[500],
                    ),
              ),
              const SizedBox(height: 18.0),
              Divider(
                color: AppColor.neutral[50],
                thickness: 8.0,
              ),
            ],
          ),
        ),
      );
    }

    Widget listAddress() {
      return ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          addressCard(),
          addressCard(),
          addressCard(),
          addressCard(),
          addressCard(),
          addressCard(),
        ],
      );
    }

    Widget addButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            AppPrimaryFullButton(
              "Tambah",
              () {},
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: listAddress()),
        addButton(),
      ],
    );
  }
}
