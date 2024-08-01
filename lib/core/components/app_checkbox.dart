import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  final double size;
  final bool isCircle;
  final Color activeColor;

  const AppCheckbox(
    this.value,
    this.onChanged, {
    this.size = 24,
    this.isCircle = false,
    this.activeColor = AppColor.primary,
    super.key,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Checkbox(
        value: widget.value,
        checkColor: AppColor.white,
        activeColor: widget.activeColor,
        shape: widget.isCircle ? const CircleBorder() : null,
        side: const BorderSide(
          color: AppColor.white,
          width: 2,
        ),
        onChanged: (value) {
          widget.onChanged(value!);
        },
      ),
    );
  }
}
