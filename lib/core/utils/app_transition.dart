import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppTransition {
  static PageTransition pushTransition(
    Widget child,
    RouteSettings settings,
  ) =>
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: child,
        settings: settings,
      );

  static PageTransition pushAndRemoveUntilTransition(
    Widget child,
    RouteSettings settings,
  ) =>
      PageTransition(
        type: PageTransitionType.theme,
        child: child,
        duration: const Duration(milliseconds: 500),
        settings: settings,
      );

  static PageTransition popTransition(
    Widget child,
    RouteSettings settings,
  ) =>
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: child,
        settings: settings,
      );
}

RouteSettings appRouteSettings(String nameRoute, {Object? arguments}) {
  return RouteSettings(
    name: '/login-register',
    arguments: arguments,
  );
}
