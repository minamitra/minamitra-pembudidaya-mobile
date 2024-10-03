import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_empty_data.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/product_detail/product_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/logics/product_category_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/logics/products_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final _searchController = TextEditingController();
  String selectedCategoryId = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 48) / 2;
    final double itemWidth = size.width / 2;

    Widget searchField() {
      return Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: AppColor.neutral[300]!,
          ),
        ),
        height: 40,
        child: TextField(
          controller: _searchController,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.search,
          style: AppTextStyle.blackSmallText,
          decoration: InputDecoration(
            isCollapsed: true,
            hintStyle: appTextTheme(context).bodySmall?.copyWith(
                  color: AppColor.neutral[500],
                ),
            hintText: 'Cari Produk',
            prefixIcon: const Icon(
              Icons.search,
              color: AppColor.black,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            fillColor: AppColor.white,
          ),
          onSubmitted: (value) {
            context.read<ProductsCubit>().getProducts(
                  name: value,
                  categoryId: selectedCategoryId,
                );
          },
        ),
      );
    }

    Widget listChip() {
      return BlocBuilder<ProductCategoryCubit, ProductCategoryState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return SizedBox(
              height: 40.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 8.0);
                },
                itemBuilder: (context, index) {
                  return const AppShimmer(
                    40,
                    80,
                    40,
                  );
                },
              ),
            );
          }
          if (state.status.isLoaded) {
            return state.categoryProduct.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: 40.0,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoryProduct.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 8.0);
                      },
                      itemBuilder: (context, index) {
                        return FilterChip(
                          label: Text(
                            state.categoryProduct[index].name ?? '-',
                            textAlign: TextAlign.start,
                            style: appTextTheme(context).bodySmall?.copyWith(
                                  color: selectedCategoryId ==
                                          state.categoryProduct[index].id
                                      ? AppColor.primary[500]
                                      : AppColor.neutral[400],
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          selected: selectedCategoryId ==
                              state.categoryProduct[index].id,
                          onSelected: (value) {
                            setState(() {
                              if (selectedCategoryId ==
                                  state.categoryProduct[index].id) {
                                selectedCategoryId = "";
                              } else {
                                selectedCategoryId =
                                    state.categoryProduct[index].id!;
                              }
                              context.read<ProductsCubit>().getProducts(
                                    name: _searchController.text,
                                    categoryId: selectedCategoryId,
                                  );
                            });
                          },
                          side: BorderSide(
                            color: selectedCategoryId ==
                                    state.categoryProduct[index].id
                                ? AppColor.secondary
                                : AppColor.transparent,
                          ),
                          selectedColor: AppColor.primary[100],
                          backgroundColor: AppColor.neutral[100],
                          showCheckmark: false,
                          checkmarkColor: AppColor.primary[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        );
                      },
                    ),
                  );
          }

          return const SizedBox();
        },
      );
    }

    Widget itemProduct(ProductsResponseData data) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(AppTransition.pushTransition(
            ProductDetailPage(data),
            ProductDetailPage.routeSettings(),
          ));
        },
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: AppNetworkImage(
                    data.imageUrl ?? "",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.categoryName ?? '-',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).labelLarge?.copyWith(
                            color: AppColor.neutral[500],
                          ),
                    ),
                    const SizedBox(height: 6.0),
                    Flexible(
                      child: Text(
                        data.name ?? '-',
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              color: AppColor.black,
                              fontWeight: FontWeight.w700,
                            ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      data.sellPrice == null
                          ? '-'
                          : appConvertCurrency(double.parse(data.sellPrice!)),
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodyMedium?.copyWith(
                            color: AppColor.accent,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget listProduct() {
      return BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: itemWidth / itemHeight,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const AppShimmer(
                    double.infinity,
                    double.infinity,
                    10,
                  );
                },
              ),
            );
          }
          if (state.status.isLoaded) {
            return state.products.isEmpty
                ? const Padding(
                    padding: EdgeInsets.fromLTRB(16, 98, 16, 0),
                    child: AppEmptyData("Belum ada data produk"),
                  )
                : Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: itemWidth / itemHeight,
                      ),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return itemProduct(state.products[index]);
                      },
                    ),
                  );
          }

          return const SizedBox();
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 16.0),
          searchField(),
          const SizedBox(height: 16.0),
          listChip(),
          const SizedBox(height: 16.0),
          listProduct(),
        ],
      ),
    );
  }
}
