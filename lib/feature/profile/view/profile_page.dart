import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile/view/profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/profile-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBarWithBucket(context, "Profil"),
      body: ProfileView(),
    );
  }
}
