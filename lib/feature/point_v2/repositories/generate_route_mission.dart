import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/view/activity_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event/view/event_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/views/products_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/profile_member_page.dart';

void generateRouteMission(
  BuildContext context,
  String routeName,
) {
  log(routeName);
  if (routeName == ProductsPage.routeSettings().name) {
    Navigator.of(context).pushReplacement(
      AppTransition.pushTransition(
        const ProductsPage(),
        ProductsPage.routeSettings(),
      ),
    );
  } else if (routeName == ActivityPage.routeSettings().name) {
    Navigator.of(context).pop(ActivityPage.routeSettings().name);
  } else if (routeName == EventPage.route().name) {
    Navigator.of(context).pushReplacement(
      AppTransition.pushTransition(
        const EventPage(),
        EventPage.route(),
      ),
    );
  } else if (routeName == ProfileMemberPage.routeSettings.name) {
    Navigator.of(context).pushReplacement(
      AppTransition.pushTransition(
        const ProfileMemberPage(),
        ProfileMemberPage.routeSettings,
      ),
    );
  }
}
