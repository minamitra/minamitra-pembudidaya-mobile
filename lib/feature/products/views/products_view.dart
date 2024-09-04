import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/product_detail/product_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final _searchController = TextEditingController();

  List<String> listFilter = [
    "Semua",
    "Pakan Ikan",
    "Obat Ikan",
    "Bibit Ikan",
  ];
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = listFilter[0];
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
        ),
        height: 40,
        child: TextField(
          controller: _searchController,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: TextInputAction.search,
          style: AppTextStyle.blackSmallText,
          decoration: InputDecoration(
            isCollapsed: true,
            hintStyle: AppTextStyle.blackSmallText,
            hintText: 'Cari kajian',
            prefixIcon: const Icon(
              Icons.search,
              color: AppColor.black,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            fillColor: AppColor.white,
          ),
        ),
      );
    }

    Widget itemProduct() {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(AppTransition.pushTransition(
            const ProductDetailPage(),
            ProductDetailPage.routeSettings(),
          ));
        },
        child: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: AspectRatio(
                  aspectRatio: 1.1,
                  child: Image.asset(
                    AppAssets.product1Image,
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
                      'Pakan Ikan',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context).bodySmall?.copyWith(
                            color: AppColor.neutral[500],
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Flexible(
                      child: Text(
                        'Pakan Siap Cetak (PSC) Mina Mitra Mandirin',
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
                      'Rp190.000',
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

    Widget listChip() {
      return SizedBox(
        height: 40.0,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: listFilter.length,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 8.0);
          },
          itemBuilder: (context, index) {
            return FilterChip(
              label: Text(
                listFilter[index],
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodyMedium?.copyWith(
                      color: selectedFilter == listFilter[index]
                          ? AppColor.primary[500]
                          : AppColor.neutral[400],
                      fontWeight: FontWeight.w600,
                    ),
              ),
              selected: selectedFilter == listFilter[index],
              onSelected: (value) {
                setState(() {
                  selectedFilter = listFilter[index];
                });
              },
              side: BorderSide(
                color: selectedFilter == listFilter[index]
                    ? AppColor.secondary
                    : AppColor.transparent,
              ),
              selectedColor: AppColor.primary[100],
              backgroundColor: AppColor.neutral[100],
              checkmarkColor: AppColor.primary[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            );
          },
        ),
      );
    }

    Widget listProduct() {
      return Expanded(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: itemWidth / itemHeight,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return itemProduct();
          },
        ),
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
