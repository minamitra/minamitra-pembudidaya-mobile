import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/profile_member_view.dart';

class ProfileMemberPage extends StatelessWidget {
  const ProfileMemberPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/profile-member-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Profil Saya",
      ),
      body: ProfileMemberView(),
    );
  }
}
