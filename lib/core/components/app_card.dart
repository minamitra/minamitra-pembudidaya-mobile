import 'dart:typed_data';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

// -------DEFAULT CARD----------

class AppDefaultCard extends StatelessWidget {
  const AppDefaultCard({
    required this.child,
    this.backgroundCardColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
    this.margin,
    this.isShadow = true,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundCardColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool isShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        border:
            Border.all(color: borderColor ?? AppColor.black.withOpacity(0.03)),
        color: backgroundCardColor ?? AppColor.white,
        boxShadow: isShadow
            ? [
                BoxShadow(
                  color: AppColor.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

// -------PICK IMAGE CARD----------
class AppPickImageCard extends StatelessWidget {
  const AppPickImageCard(this.onTap,
      {required this.listImage, required this.onTapImage, Key? key})
      : super(key: key);

  final List<Uint8List> listImage;
  final void Function() onTap;
  final Function(int) onTapImage;

  @override
  Widget build(BuildContext context) {
    return AppAnimatedSize(
      isShow: true,
      child: SizedBox(
        height: 150,
        child: listImage.isEmpty
            ? InkWell(
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppColor.neutral[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.galleryIcon,
                        height: 32,
                      ),
                      const SizedBox(height: 18.0),
                      Text(
                        "Tambah Gambar",
                        style: appTextTheme(context).bodySmall?.copyWith(
                              color: AppColor.neutral[500],
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemCount: listImage.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.memory(
                                          listImage[index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      AppPrimaryButton("Hapus", () {
                                        onTapImage(index);
                                        Navigator.pop(context);
                                      }),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.memory(
                              listImage[index],
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: AppColor.neutral[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.galleryIcon,
                              height: 32,
                            ),
                            const SizedBox(height: 18.0),
                            Text(
                              "Tambah Gambar",
                              style: appTextTheme(context).bodySmall?.copyWith(
                                    color: AppColor.neutral[500],
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
