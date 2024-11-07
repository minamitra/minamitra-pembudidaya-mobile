import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/logic/address_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/repositories/member_address_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_member_address/view/detail_member_address_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddressMemberView extends StatefulWidget {
  const AddressMemberView({super.key});

  @override
  State<AddressMemberView> createState() => _AddressMemberViewState();
}

class _AddressMemberViewState extends State<AddressMemberView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    Widget addressCard({
      required MemberAddressResponseData data,
      required void Function() onTap,
    }) {
      return InkWell(
        onTap: onTap,
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
                          data.title.handlingEmptyString(),
                          style: appTextTheme(context)
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${data.name.handlingEmptyString()} (${data.phone.handlingEmptyString()})',
                          style: appTextTheme(context).bodySmall?.copyWith(
                                color: AppColor.neutral[500],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (data.isPrimaryBool ?? false)
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
                        'Utama',
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
                '${data.address}, Kec. ${data.subdistrictName?.toLowerCase()}, ${data.cityName?.toLowerCase()}, ${data.provinceName?.toLowerCase()}',
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
      return BlocBuilder<AddressMemberCubit, AddressMemberState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 18.0,
              ),
              shrinkWrap: true,
              itemCount: 10,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const AppShimmer(
                  125.0,
                  double.infinity,
                  8.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                );
              },
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.memberAddressResponse?.length,
            itemBuilder: (context, index) {
              return addressCard(
                data: state.memberAddressResponse![index],
                onTap: () {
                  Navigator.of(context)
                      .push(
                    AppTransition.pushTransition(
                      DetailMemberAddressPage(
                        existData: state.memberAddressResponse![index],
                      ),
                      DetailMemberAddressPage.routeSettings(),
                    ),
                  )
                      .then((value) {
                    if (value != null && value) {
                      context.read<AddressMemberCubit>().init();
                    }
                  });
                },
              );
            },
          );
        },
      );
    }

    Widget addButton() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            AppPrimaryFullButton(
              'Tambah',
              () {
                Navigator.of(context)
                    .push(
                  AppTransition.pushTransition(
                    const DetailMemberAddressPage(),
                    DetailMemberAddressPage.routeSettings(),
                  ),
                )
                    .then((value) {
                  if (value != null && value) {
                    context.read<AddressMemberCubit>().init();
                  }
                });
              },
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
