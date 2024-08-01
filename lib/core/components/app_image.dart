import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AppNetworkImage(
    this.url, {
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: url,
      errorWidget: (context, url, error) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
      // Image.asset(
      //   AppAssets.minamitra - pembudidaya - mobileSquareLogo,
      //   fit: BoxFit.cover,
      // ),
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: AppShimmer(
          height,
          width,
          8,
        ),
      ),
      fit: fit,
      width: width,
      height: height,
    );
  }
}
