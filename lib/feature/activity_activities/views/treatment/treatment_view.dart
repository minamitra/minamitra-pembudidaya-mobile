import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/logic/treatment_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_activities/repositories/treatment_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_treatment_detail/view/activity_treatment_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class TreatmentView extends StatefulWidget {
  final int fishpondId;
  final int fishpondcycleId;
  final String datetime;

  const TreatmentView(
    this.fishpondId,
    this.fishpondcycleId,
    this.datetime, {
    super.key,
  });

  @override
  State<TreatmentView> createState() => _TreatmentViewState();
}

class _TreatmentViewState extends State<TreatmentView> {
  @override
  Widget build(BuildContext context) {
    Widget itemCard(TreatmentResponseData data) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(AppTransition.pushTransition(
            ActivityTreatmentDetailPage(data),
            ActivityTreatmentDetailPage.routeSettings(),
          ))
              .then((value) {
            if (value == "refresh") {
              context.read<TreatmentCubit>().init(
                    widget.fishpondId,
                    widget.fishpondcycleId,
                    widget.datetime,
                  );
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name ?? "-",
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.primary,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        data.datetime != null ? data.datetime.toString() : "-",
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).labelLarge?.copyWith(
                              color: AppColor.black[500],
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AppDialogComponent(
                            title: "Hapus Perlakuan",
                            subTitle:
                                "Apakah Anda yakin ingin menghapus perlakuan ini?",
                            buttons: [
                              Expanded(
                                child: AppPrimaryOutlineFullButton(
                                  "Batal",
                                  () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: AppPrimaryFullButton(
                                  "Hapus",
                                  () {
                                    context
                                        .read<TreatmentCubit>()
                                        .deleteTreatment(
                                          data.id ?? "",
                                          widget.fishpondId,
                                          widget.fishpondcycleId,
                                          widget.datetime,
                                        );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Image.asset(
                      AppAssets.trashIcon,
                      height: 20.0,
                      color: AppColor.neutral[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Image.asset(AppAssets.dollarIcon, height: 20.0),
                  const SizedBox(width: 12.0),
                  Text(
                    appConvertCurrency(
                        data.cost != null ? double.parse(data.cost!) : 0),
                    style: appTextTheme(context).titleSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<TreatmentCubit, TreatmentState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (context, index) => Container(
              height: 16.0,
              width: double.infinity,
              color: AppColor.neutralBlueGrey[50],
            ),
            itemBuilder: (context, index) {
              return const AppShimmer(
                120,
                double.infinity,
                0,
              );
            },
          );
        }

        if (state.status.isLoaded) {
          return state.treatments!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(16, 84, 16, 0),
                  child: AppEmptyData(
                      "Belum ada data, tekan tombol + untuk menambahkan aktivitas baru"),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.treatments!.length,
                  separatorBuilder: (context, index) => Container(
                    height: 16.0,
                    width: double.infinity,
                    color: AppColor.neutralBlueGrey[50],
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 18.0,
                  //     vertical: 16.0,
                  //   ),
                  //   color: AppColor.neutralBlueGrey[50],
                  //   child: Text(
                  //     "Hari ini",
                  //     style: appTextTheme(context).titleSmall?.copyWith(
                  //           color: AppColor.neutral[400],
                  //         ),
                  //   ),
                  // ),
                  itemBuilder: (context, index) {
                    return itemCard(state.treatments![index]);
                  },
                );
        }

        return const SizedBox();
      },
    );
  }
}
