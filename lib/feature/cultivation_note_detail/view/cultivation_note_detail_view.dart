import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class CultivationNoteDetailView extends StatefulWidget {
  const CultivationNoteDetailView({super.key});

  @override
  State<CultivationNoteDetailView> createState() =>
      _CultivationNoteDetailViewState();
}

class _CultivationNoteDetailViewState extends State<CultivationNoteDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<CultivationCubit>().addCommentReaded();
  }

  @override
  Widget build(BuildContext context) {
    final CultivationCubit cultivationCubit = context.read<CultivationCubit>();

    Widget header() {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: SizedBox(
              height: 36.0,
              width: 36.0,
              child: Image.network(
                cultivationCubit.data?.userImageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (
                  BuildContext context,
                  Object obj,
                  StackTrace? trace,
                ) {
                  return Image.asset(
                    AppAssets.profileImageDummy,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cultivationCubit.data?.userName.handlingEmptyString() ?? '',
                style: appTextTheme(context).titleSmall,
              ),
              const SizedBox(height: 4.0),
              Text(
                AppConvertDateTime().edmy(
                  cultivationCubit.data?.createDatetime ?? DateTime.now(),
                ),
                style: appTextTheme(context)
                    .labelLarge
                    ?.copyWith(color: AppColor.neutral[400]),
              ),
            ],
          ),
        ],
      );
    }

    List<Widget> attachment() {
      return (cultivationCubit.data?.attachmentJsonArray?.isEmpty ?? true)
          ? [
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: AppEmptyData(
                  'Belum ada lampiran\ndari pendamping',
                  isCenter: true,
                ),
              ),
            ]
          : List.generate(
              cultivationCubit.data?.attachmentJsonArray?.length ?? 0,
              (index) {
                return Container(
                  height: 150.0,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 18.0),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: InkWell(
                      onTap: () {
                        showImageViewer(
                          context,
                          Image.network(
                            cultivationCubit
                                    .data?.attachmentJsonArray?[index] ??
                                '',
                          ).image,
                          immersive: false,
                          useSafeArea: true,
                          swipeDismissible: true,
                          doubleTapZoomable: true,
                          backgroundColor: Colors.black.withOpacity(0.7),
                        );
                      },
                      child: Image.network(
                        cultivationCubit.data?.attachmentJsonArray?[index],
                        errorBuilder: (
                          BuildContext context,
                          Object obj,
                          StackTrace? trace,
                        ) {
                          return const SizedBox();
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
    }

    return BlocBuilder<CultivationCubit, CultivationState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == GlobalState.error) {
          return AppEmptyData(
            state.errorMessage,
            isCenter: true,
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          children: [
            const SizedBox(height: 18.0),
            header(),
            const SizedBox(height: 18.0),
            AppDividerSmall(),
            const SizedBox(height: 18.0),
            Text(
              cultivationCubit.data?.content.handlingEmptyString() ?? '',
              style: appTextTheme(context).bodySmall,
            ),
            ...attachment(),
          ],
        );
      },
    );
  }
}
