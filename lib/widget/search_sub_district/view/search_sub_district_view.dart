import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/widget/search_sub_district/logic/search_sub_district_cubit.dart';

Widget showSearchWidget({
  required BuildContext context,
  required Widget child,
}) {
  return BlocProvider(
    create: (context) => SearchSubDistrictCubit(RefServiceImpl.create()),
    child: BlocBuilder<SearchSubDistrictCubit, SearchSubDistrictState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (modalContext) {
                final TextEditingController searchController =
                    TextEditingController();

                return BlocProvider.value(
                  value: BlocProvider.of<SearchSubDistrictCubit>(context),
                  child: AppBottomSheet(
                    'Cari kabupaten/kota',
                    Column(
                      children: [
                        AppSearchField(
                          controller: searchController,
                          hintText: 'Cari kabupaten/kota',
                          onChanged: (String value) {
                            if (value.length > 3) {
                              context
                                  .read<SearchSubDistrictCubit>()
                                  .searchSubDistrict(value);
                            }
                          },
                        ),
                        const SizedBox(height: 18.0),
                        BlocBuilder<SearchSubDistrictCubit,
                            SearchSubDistrictState>(
                          builder: (context, state) {
                            if (state.status.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Expanded(
                              child: ListView.builder(
                                itemCount:
                                    state.subDistrictResponse?.data?.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      state.subDistrictResponse?.data?[index]
                                              .name ??
                                          '-',
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.8,
                    actions: const [],
                  ),
                );
              },
            );
          },
          child: child,
        );
      },
    ),
  );
}

Future showSearchSubDistrictDialog(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      final TextEditingController searchController = TextEditingController();

      return AppBottomSheet(
        'Cari kabupaten/kota',
        Column(
          children: [
            AppSearchField(
              controller: searchController,
              hintText: 'Cari kabupaten/kota',
              onChanged: (String value) {
                if (value.length > 3) {
                  context
                      .read<SearchSubDistrictCubit>()
                      .searchSubDistrict(value);
                }
              },
            ),
            const SizedBox(height: 18.0),
            BlocBuilder<SearchSubDistrictCubit, SearchSubDistrictState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: state.subDistrictResponse?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          state.subDistrictResponse?.data?[index].name ?? '-',
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        actions: const [],
      );
    },
  );
}
