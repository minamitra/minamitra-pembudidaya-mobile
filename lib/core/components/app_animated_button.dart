import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

class AppAnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool loading;
  final double height, width;

  const AppAnimatedButton(
    this.text,
    this.onPressed, {
    this.loading = false,
    this.height = 50.0,
    this.width = 50.0,
    Key? key,
  }) : super(key: key);

  @override
  AppAnimatedButtonState createState() => AppAnimatedButtonState();
}

class AppAnimatedButtonState extends State<AppAnimatedButton>
    with SingleTickerProviderStateMixin {
  bool _onTapped = false;

  Widget button() => AppPrimaryButton(
        widget.text,
        () async {
          if (_onTapped) return;
          _onTapped = true;
          await Future.delayed(const Duration(milliseconds: 200));
          _onTapped = false;
          widget.onPressed();
        },
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: widget.loading
            ? Container(
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: const CircularProgressIndicator(color: Colors.white),
                ),
              )
            : button(),
      ),
    );
  }
}
