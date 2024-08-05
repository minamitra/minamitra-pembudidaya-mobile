import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';

class AppModuleCard extends StatelessWidget {
  const AppModuleCard(
    this.name,
    this.icon,
    this.onTap, {
    this.width,
    this.height,
    this.isLocalAsset = false,
    this.bgColor = AppColor.transparent,
    this.isBorder = false,
    Key? key,
  }) : super(key: key);

  final String name;
  final String icon;
  final double? width;
  final double? height;
  final void Function() onTap;
  final bool isLocalAsset;
  final Color bgColor;
  final bool isBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 6.0,
        ),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: isBorder
              ? Border.all(color: Colors.black.withOpacity(0.03))
              : null,
          color: bgColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isLocalAsset
                ? Flexible(
                    flex: 3,
                    child: Image.asset(
                      icon,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  )
                : Flexible(
                    flex: 3,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColor.primary[50],
                        ),
                        child: Image.asset(
                          icon,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 4.0),
            Flexible(
              flex: 2,
              child: Text(
                name,
                style: AppTextStyle.blackExtraSmallText,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
