import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/logic/profile_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/profile_member_view.dart';

class ProfileMemberPage extends StatelessWidget {
  const ProfileMemberPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/profile-member-page');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileMemberCubit>(
          create: (context) => ProfileMemberCubit(),
        ),
      ],
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Profil Saya",
        ),
        body: ProfileMemberView(),
      ),
    );
  }
}
