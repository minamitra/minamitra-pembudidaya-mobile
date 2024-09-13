import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

enum _CustomButtonStyle {
  primary,
  primaryDisable,
  primaryOutline,
  white,
  accent,
  accentOutline,
}

extension _CustomButtonStyleExtension on _CustomButtonStyle {
  ButtonStyle get style {
    switch (this) {
      case _CustomButtonStyle.primary:
        return ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          foregroundColor: WidgetStateProperty.all(AppColor.primary),
          backgroundColor: WidgetStateProperty.all(AppColor.primary),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          elevation: WidgetStateProperty.all(0),
        );
      case _CustomButtonStyle.primaryDisable:
        return ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          foregroundColor:
              WidgetStateProperty.all(AppColor.primary.withOpacity(0.3)),
          backgroundColor:
              WidgetStateProperty.all(AppColor.primary.withOpacity(0.3)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          elevation: WidgetStateProperty.all(0),
        );
      case _CustomButtonStyle.primaryOutline:
        return ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          foregroundColor: WidgetStateProperty.all(AppColor.primary),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppColor.primary, width: 1.5),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
        );
      case _CustomButtonStyle.white:
        return ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          foregroundColor: WidgetStateProperty.all(AppColor.white),
          backgroundColor: WidgetStateProperty.all(AppColor.white),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          elevation: WidgetStateProperty.all(0),
        );
      case _CustomButtonStyle.accent:
        return ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          foregroundColor: WidgetStateProperty.all(AppColor.accent),
          backgroundColor: WidgetStateProperty.all(AppColor.accent),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          elevation: WidgetStateProperty.all(0),
        );
      case _CustomButtonStyle.accentOutline:
        return ButtonStyle(
          padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
          foregroundColor: WidgetStateProperty.all(AppColor.accent),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppColor.accent, width: 1.5),
            ),
          ),
          elevation: WidgetStateProperty.all(0),
        );
    }
  }
}

class _CustomButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  final _CustomButtonStyle buttonStyle;
  final bool isFull;
  final double? customWidth;
  final double? height;

  const _CustomButton(
    this.child,
    this.onPressed, {
    this.buttonStyle = _CustomButtonStyle.primary,
    this.isFull = false,
    this.customWidth,
    this.height = 53.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFull ? double.infinity : customWidth,
      height: height,
      child: ElevatedButton(
        style: buttonStyle.style,
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  _CustomButton copyWith({
    Widget? child,
    Function()? onPressed,
    _CustomButtonStyle? buttonStyle,
  }) {
    return _CustomButton(
      child ?? this.child,
      onPressed ?? this.onPressed,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }
}

class AppPrimaryButton extends _CustomButton {
  AppPrimaryButton(
    String text,
    Function() onPressed, {
    double? width,
  }) : super(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(text, style: AppTextStyle.whiteSmallBoldText),
          ),
          onPressed,
          buttonStyle: _CustomButtonStyle.primary,
          customWidth: width,
        );
}

class AppPrimaryFullButton extends _CustomButton {
  AppPrimaryFullButton(
    String text,
    Function() onPressed, {
    double height = 53.0,
    Widget? prefixIcon,
    bool isActive = true,
  }) : super(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixIcon != null
                  ? Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: prefixIcon,
                    )
                  : const SizedBox(),
              Text(
                text,
                style: AppTextStyle.whiteBoldText,
              ),
            ],
          ),
          onPressed,
          buttonStyle: isActive
              ? _CustomButtonStyle.primary
              : _CustomButtonStyle.primaryDisable,
          isFull: true,
          height: height,
        );
}

class AppPrimaryOutlineButton extends _CustomButton {
  AppPrimaryOutlineButton(
    String text,
    Function() onPressed, {
    double height = 53.0,
    Widget? prefixIcon,
  }) : super(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixIcon != null
                  ? Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: prefixIcon,
                    )
                  : const SizedBox(),
              Text(
                text,
                style: AppTextStyle.primaryBoldText,
              ),
            ],
          ),
          onPressed,
          buttonStyle: _CustomButtonStyle.primaryOutline,
          height: height,
        );
}

class AppPrimaryOutlineFullButton extends _CustomButton {
  AppPrimaryOutlineFullButton(
    String text,
    Function() onPressed,
  ) : super(
          Text(
            text,
            style: AppTextStyle.primaryBoldText,
          ),
          onPressed,
          buttonStyle: _CustomButtonStyle.primaryOutline,
          isFull: true,
        );
}

class AppWhiteButton extends _CustomButton {
  AppWhiteButton(
    String text,
    Function() onPressed, {
    double? height = 53.0,
  }) : super(
          Text(
            text,
            style: AppTextStyle.primarySmallBoldText.copyWith(
              color: AppColor.primary[500],
            ),
          ),
          onPressed,
          buttonStyle: _CustomButtonStyle.white,
          height: height,
        );
}

class AppWhiteFullButton extends _CustomButton {
  AppWhiteFullButton(
    String text,
    Function() onPressed, {
    Widget? prefixIcon,
  }) : super(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixIcon != null
                  ? Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: prefixIcon,
                    )
                  : const SizedBox(),
              Text(
                text,
                style: AppTextStyle.primarySmallBoldText.copyWith(
                  color: AppColor.primary[700],
                ),
              ),
            ],
          ),
          onPressed,
          buttonStyle: _CustomButtonStyle.white,
          isFull: true,
        );
}

class AppAccentButton extends _CustomButton {
  AppAccentButton(
    Widget text,
    Function() onPressed, {
    double? height = 53.0,
  }) : super(
          text,
          onPressed,
          buttonStyle: _CustomButtonStyle.accent,
          height: height,
        );
}

class AppAccentOutlineButton extends _CustomButton {
  AppAccentOutlineButton(
    Widget text,
    Function() onPressed, {
    double? height = 53.0,
  }) : super(
          text,
          onPressed,
          buttonStyle: _CustomButtonStyle.accentOutline,
          height: height,
        );
}

class AppPrimaryGradientButton extends StatelessWidget {
  const AppPrimaryGradientButton(this.text, this.onTap, {super.key});

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF155ED0),
              Color(0xFF1049A2),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF000000),
            ),
          ],
        ),
        child: Text(
          text,
          style:
              appTextTheme(context).titleSmall?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class AppGreenGradientButton extends StatelessWidget {
  const AppGreenGradientButton(this.text, this.onTap, {super.key});

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF14B8A6),
              Color(0xFF0D9488),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF000000),
            ),
          ],
        ),
        child: Text(
          text,
          style:
              appTextTheme(context).titleSmall?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
