import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point/logic/history_point_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/history_point_detail/view/history_point_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class HistoryPointView extends StatefulWidget {
  const HistoryPointView({super.key});

  @override
  State<HistoryPointView> createState() => _HistoryPointViewState();
}

class _HistoryPointViewState extends State<HistoryPointView> {
  final TextEditingController searchController = TextEditingController();

  List<String> listFilter = [
    "Semua",
    "Tarik Tunai",
    "Konversi Saldo",
    "Aktivitas",
  ];

  @override
  Widget build(BuildContext context) {
    Widget searchField() {
      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: AppValidatorTextField(
          controller: searchController,
          withUpperLabel: false,
          hintText: "Cari data ...",
          onChanged: (value) {},
        ),
      );
    }

    Widget filterData() {
      return BlocBuilder<HistoryPointCubit, HistoryPointState>(
        builder: (context, state) {
          return Container(
            constraints: const BoxConstraints(
              minHeight: 62.0,
              minWidth: double.infinity,
            ),
            padding: const EdgeInsets.only(bottom: 18.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Row(
                children: List.generate(
                  listFilter.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 18.0 : 0,
                        right: 12.0,
                      ),
                      child: FilterChip(
                        label: Text(
                          listFilter[index],
                          textAlign: TextAlign.start,
                          style: state.selectedFilter == index
                              ? appTextTheme(context)
                                  .titleSmall
                                  ?.copyWith(color: AppColor.secondary[900])
                              : appTextTheme(context)
                                  .bodySmall
                                  ?.copyWith(color: AppColor.neutral[500]),
                        ),
                        selected: state.selectedFilter == index,
                        onSelected: (value) {
                          context
                              .read<HistoryPointCubit>()
                              .onChangeFilter(index);
                        },
                        side: BorderSide(
                          color: state.selectedFilter == index
                              ? AppColor.secondary[900]!
                              : AppColor.neutralBlueGrey[200]!,
                        ),
                        selectedColor: AppColor.primary[100],
                        backgroundColor: AppColor.neutral[100],
                        showCheckmark: false,
                        checkmarkColor: AppColor.primary[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    }

    Widget listHistoryItem({
      required String title,
      required String dateTime,
      required int point,
      String? balance,
    }) {
      return Container(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primary[500],
              ),
              child: Icon(
                Icons.wallet,
                color: AppColor.white,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: appTextTheme(context)
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    dateTime,
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: AppColor.neutralBlueGrey[400]),
                  ),
                ],
              ),
            ),
            balance != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${point <= 0 ? "-" : "+"} $point poin",
                        style: appTextTheme(context)
                            .titleSmall
                            ?.copyWith(color: AppColor.accent[900]),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "+ Rp 50,000",
                        style: appTextTheme(context)
                            .titleSmall
                            ?.copyWith(color: AppColor.secondary[900]),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      );
    }

    Widget listHistory() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: AppDividerSmall(),
          );
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(AppTransition.pushTransition(
                const HistoryPointDetailPage(),
                HistoryPointDetailPage.route,
              ));
            },
            child: listHistoryItem(
              title: "Tarik Tunai",
              dateTime: "12 Januari 2021",
              point: 100,
              balance: "+ Rp 50,000",
            ),
          );
        },
      );
    }

    return Column(
      children: [
        searchField(),
        filterData(),
        Expanded(child: listHistory()),
      ],
    );
  }
}
