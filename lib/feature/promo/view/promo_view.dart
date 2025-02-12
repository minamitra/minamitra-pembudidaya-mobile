import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/product_detail/product_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/repositories/products_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/promo/repository/dummy_discount_product.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PromoView extends StatefulWidget {
  const PromoView({super.key});

  @override
  State<PromoView> createState() => _PromoViewState();
}

class _PromoViewState extends State<PromoView> {
  @override
  Widget build(BuildContext context) {
    final double itemWidth = MediaQuery.sizeOf(context).width / 2.3;
    final double itemHeight = itemWidth + 90.0;

    Widget itemProduct(ProductsResponseData data) {
      return InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //   AppTransition.pushTransition(
          //     ProductDetailPage(
          //       data,
          //       isProductPromo: true,
          //     ),
          //     ProductDetailPage.routeSettings(),
          //   ),
          // );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: itemWidth,
              height: itemHeight - 90.0,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: AppNetworkImage(
                        data.imageUrl ?? '',
                        width: itemWidth,
                        height: itemHeight - 90.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.red[600],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(4.0),
                        bottomRight: Radius.circular(4.0),
                      ),
                    ),
                    child: Text(
                      '10% Off',
                      textAlign: TextAlign.start,
                      style: appTextTheme(context)
                          .labelSmall
                          ?.copyWith(color: AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.categoryName ?? '-',
                          textAlign: TextAlign.start,
                          style: appTextTheme(context).labelLarge?.copyWith(
                                color: AppColor.neutral[500],
                              ),
                        ),
                      ),
                      Text(
                        "Stok ${(double.tryParse(data.stock ?? '0') ?? 0).toStringAsFixed(0)}",
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).labelSmall?.copyWith(
                              color: AppColor.neutral[500],
                            ),
                      ),
                    ],
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          'Rp 200.000',
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: appTextTheme(context).labelSmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppColor.neutral[400],
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        data.sellPrice == null
                            ? '-'
                            : appConvertCurrency(double.parse(data.sellPrice!)),
                        textAlign: TextAlign.start,
                        style: appTextTheme(context).bodySmall?.copyWith(
                              color: AppColor.accent,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget productItem(List<ProductsResponseData> discountProductItem) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: itemWidth / itemHeight,
        ),
        itemCount: discountProductItem.length,
        itemBuilder: (context, index) {
          return itemProduct(discountProductItem[index]);
        },
      );
    }

    Widget productSection(
      String discountTitle,
      DateTime endTime,
      List<ProductsResponseData> discountProductItem,
    ) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  discountTitle,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context)
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(
                Icons.access_time_outlined,
                size: 18.0,
                color: AppColor.primary[500],
              ),
              const SizedBox(width: 8.0),
              Countdown(
                seconds: endTime.difference(DateTime.now()).inSeconds,
                build: (BuildContext context, double time) {
                  Duration existDuration = Duration(
                    seconds: int.parse(time.toStringAsFixed(0)),
                  );
                  return Text(
                    "${existDuration.inHours.toString().padLeft(2, '0')}:${existDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${existDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: AppColor.primary[500]),
                  );
                },
                interval: const Duration(seconds: 1),
                onFinished: () {},
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          productItem(discountProductItem),
          const SizedBox(height: 18.0),
          AppDivider(
            color: AppColor.neutral[100],
            thickness: 12.0,
          ),
          const SizedBox(height: 18.0),
        ],
      );
    }

    Widget product() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return productSection(
            'Flash Sale $index',
            DateTime.now().add(const Duration(days: 14)),
            dummyDiscountProduct,
          );
        },
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const SizedBox(height: 18.0),
        product(),
        const SizedBox(height: 18.0),
      ],
    );
  }
}
