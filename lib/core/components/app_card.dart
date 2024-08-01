import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:flutter/material.dart';

// -------DEFAULT CARD----------

class AppDefaultCard extends StatelessWidget {
  const AppDefaultCard({
    required this.child,
    this.backgroundCardColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
    this.margin,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundCardColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 15.0,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        border:
            Border.all(color: borderColor ?? Colors.black.withOpacity(0.03)),
        color: backgroundCardColor ?? AppColor.white,
      ),
      child: child,
    );
  }
}
