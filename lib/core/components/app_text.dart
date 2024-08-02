import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';

const defaultFontFamily = Injection.fontFamily;

enum _CustomColorType {
  black,
  white,
  primary,
}

enum _CustomFontSizeType {
  tripleExtraSmall,
  doubleExtraSmall,
  extraSmall,
  small,
  normal,
  large,
  extraLarge,
  doubleExtraLarge,
  tripleExtraLarge,
  extraTripleLarge,
  doubleExtraTripleLarge,
}

enum _CustomFontWeightType {
  light,
  normal,
  medium,
  semiBold,
  bold,
}

enum _CustomTextAlignmentType {
  justify,
  left,
  center,
  right,
}

extension _CustomColorTypeExt on _CustomColorType {
  Color get color {
    switch (this) {
      case _CustomColorType.black:
        return AppColor.black;
      case _CustomColorType.white:
        return AppColor.white;
      case _CustomColorType.primary:
        return AppColor.primary;
    }
  }
}

extension _CustomFontSizeTypeExt on _CustomFontSizeType {
  double get size {
    switch (this) {
      case _CustomFontSizeType.tripleExtraSmall:
        return 8;
      case _CustomFontSizeType.doubleExtraSmall:
        return 10;
      case _CustomFontSizeType.extraSmall:
        return 12;
      case _CustomFontSizeType.small:
        return 14;
      case _CustomFontSizeType.normal:
        return 16;
      case _CustomFontSizeType.large:
        return 18;
      case _CustomFontSizeType.extraLarge:
        return 20;
      case _CustomFontSizeType.doubleExtraLarge:
        return 22;
      case _CustomFontSizeType.tripleExtraLarge:
        return 24;
      case _CustomFontSizeType.extraTripleLarge:
        return 28;
      case _CustomFontSizeType.doubleExtraTripleLarge:
        return 32;
    }
  }
}

extension _CustomFontWeightTypeExt on _CustomFontWeightType {
  FontWeight get weight {
    switch (this) {
      case _CustomFontWeightType.light:
        return FontWeight.w300;
      case _CustomFontWeightType.normal:
        return FontWeight.normal;
      case _CustomFontWeightType.medium:
        return FontWeight.w500;
      case _CustomFontWeightType.semiBold:
        return FontWeight.w600;
      case _CustomFontWeightType.bold:
        return FontWeight.w700;
    }
  }
}

extension _CustomTextAlignmentTypeExt on _CustomTextAlignmentType {
  TextAlign get alignment {
    switch (this) {
      case _CustomTextAlignmentType.justify:
        return TextAlign.justify;
      case _CustomTextAlignmentType.left:
        return TextAlign.left;
      case _CustomTextAlignmentType.center:
        return TextAlign.center;
      case _CustomTextAlignmentType.right:
        return TextAlign.right;
    }
  }
}

class AppTextStyle {
  static final TextTheme lightTextTheme = TextTheme(
    displayMedium: TextStyle(
      fontFamily: defaultFontFamily,
      color: _CustomColorType.black.color,
      fontSize: 36.0,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontFamily: defaultFontFamily,
      color: _CustomColorType.black.color,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    ),
  );
  static final TextTheme darkTextTheme = TextTheme(
    displayMedium: TextStyle(
      fontFamily: defaultFontFamily,
      color: _CustomColorType.white.color,
      fontSize: 36.0,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      fontFamily: defaultFontFamily,
      color: _CustomColorType.white.color,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    ),
  );

  static final blackSmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final blackText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.large.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.large.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final blackExtraLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.extraLarge.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackDoubleExtraLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.doubleExtraLarge.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackTripleExtraLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.tripleExtraLarge.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackTripleExtraLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.tripleExtraLarge.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final blackTripleExtraLargeSemiBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.tripleExtraLarge.size,
    fontWeight: _CustomFontWeightType.semiBold.weight,
  );

  static final blackMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final blackSemiBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.semiBold.weight,
  );

  static final blackExtraLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.extraLarge.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final blackDoubleExtraLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.doubleExtraLarge.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final blackDoubleExtraSmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.doubleExtraSmall.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackExtraSmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final blackDoubleExtraSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.doubleExtraSmall.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final blackExtraSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.black.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteSmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteSmallBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final whiteText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.large.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.large.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteLargeBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.large.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final whiteExtraLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.extraLarge.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteDoubleExtraLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.doubleExtraLarge.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteDoubleExtraLargeBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.doubleExtraLarge.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final whiteTripleExtraLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.tripleExtraLarge.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteTripleExtraLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.tripleExtraLarge.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteTripleExtraLargeBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.tripleExtraLarge.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final whiteMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final whiteExtraLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.extraLarge.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteExtraLargeBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.extraLarge.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final whiteDoubleExtraLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.doubleExtraLarge.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteDoubleExtraLargeSemiBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.doubleExtraLarge.size,
    fontWeight: _CustomFontWeightType.semiBold.weight,
  );

  static final whiteDoubleExtraSmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.doubleExtraSmall.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteExtraSmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final whiteDoubleExtraSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.doubleExtraSmall.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteExtraSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final whiteExtraSmallBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.white.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final primaryExtraSmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final primarySmallText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final primarySmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final primarySmallBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.small.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final primaryMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final primaryText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final primaryBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.normal.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final primaryLargeMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.large.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final primaryLargeText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.large.size,
    fontWeight: _CustomFontWeightType.normal.weight,
  );

  static final primaryExtraSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final primaryExtraSmallBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.extraSmall.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );

  static final primaryDoubleExtraSmallMediumText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.doubleExtraSmall.size,
    fontWeight: _CustomFontWeightType.medium.weight,
  );

  static final primaryTripleExtraLargeBoldText = TextStyle(
    fontFamily: defaultFontFamily,
    color: _CustomColorType.primary.color,
    fontSize: _CustomFontSizeType.tripleExtraLarge.size,
    fontWeight: _CustomFontWeightType.bold.weight,
  );
}
