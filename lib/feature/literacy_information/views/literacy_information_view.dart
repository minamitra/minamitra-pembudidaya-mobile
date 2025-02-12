import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/literacy_information_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_lazy_load.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information/logic/literacy_information_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information_detail/view/literacy_information_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class LiteracyInformationView extends StatefulWidget {
  const LiteracyInformationView({super.key});

  @override
  State<LiteracyInformationView> createState() =>
      _LiteracyInformationViewState();
}

class _LiteracyInformationViewState extends State<LiteracyInformationView> {
  final AppLazyLoad lazyLoad = AppLazyLoad();

  @override
  void initState() {
    super.initState();
    lazyLoad.onListener(
      onLoadMore: () {
        if (context.read<LiteracyInformationCubit>().state.status.isLoadMore ||
            context.read<LiteracyInformationCubit>().state.status.isLoading) {
          return;
        } else {
          context.read<LiteracyInformationCubit>().loadMoreData();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget item(
      LiteracyInformationResponseData data,
      int index,
      String imageUrl,
      String title,
      String description,
      String writer,
      String date,
    ) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            AppTransition.pushTransition(
              LiteracyInformationDetailPage(data),
              LiteracyInformationDetailPage.settings,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              Hero(
                tag: imageUrl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl,
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        color: AppColor.red[500],
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const AppShimmer(
                        100.0,
                        100.0,
                        8.0,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 18.0),
              Expanded(
                child: SizedBox(
                  height: 110.0,
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: appTextTheme(context)
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          description,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: appTextTheme(context)
                              .labelLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Row(
                        children: [
                          Text(
                            writer,
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).labelLarge?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.neutral[500],
                                ),
                          ),
                          const SizedBox(width: 4.0),
                          Icon(
                            Icons.circle,
                            size: 2.0,
                            color: AppColor.neutral[500],
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              date,
                              textAlign: TextAlign.start,
                              style: appTextTheme(context).labelLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.neutral[500],
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget onLoadMore() {
      return BlocBuilder<LiteracyInformationCubit, LiteracyInformationState>(
        builder: (context, state) {
          return AppLoadMoreWidget(status: state.status.isLoadMore);
        },
      );
    }

    return BlocBuilder<LiteracyInformationCubit, LiteracyInformationState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return const AppShimmer(
                125.0,
                double.infinity,
                8.0,
                margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              );
            },
          );
        }

        return ListView(
          controller: lazyLoad.controller,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.datas?.length ?? 0,
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: AppDividerSmall(),
                );
              },
              itemBuilder: (context, index) {
                return item(
                  state.datas![index],
                  index,
                  state.datas?[index].imageUrl ??
                      'https://www.worldanimalprotection.ca/cdn-cgi/image/width=1280,format=auto/siteassets/shutterstock_1899421132.jpg',
                  state.datas?[index].title.handlingEmptyString() ?? '-',
                  state.datas?[index].content.handlingEmptyString() ?? '-',
                  state.datas?[index].authorName.handlingEmptyString() ?? '-',
                  AppConvertDateTime().dmyName(
                    state.datas?[index].createDatetime ?? DateTime.now(),
                  ),
                );
              },
            ),
            onLoadMore(),
            const SizedBox(height: 18.0),
          ],
        );
      },
    );
  }
}
