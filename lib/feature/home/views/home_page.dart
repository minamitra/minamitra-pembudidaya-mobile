import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/home/home_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/logic/home_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/views/home_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/view/notification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(HomeServiceImpl.create())..init(),
        ),
        BlocProvider<ActivityCubit>(
          create: (context) =>
              ActivityCubit(PondServiceImpl.create())..init(limit: '1'),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state.status.isError) {
                if (state.errorMessage == 'TOKEN_EXPIRED') {
                  log('token expired execute');
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }
            },
          ),
          BlocListener<ActivityCubit, ActivityState>(
            listener: (context, state) {
              if (state.status.isError) {
                if (state.errorMessage == 'TOKEN_EXPIRED') {
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            '',
            isBackButton: false,
            customTitle: Image.asset(
              AppAssets.newLogoIcon2,
              height: 20.0,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    AppTransition.pushTransition(
                      const NotificationPage(),
                      NotificationPage.routeSettings(),
                    ),
                  );
                },
                child: Image.asset(
                  AppAssets.bellIcon,
                  height: 20.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
          body: const HomeView(),
        ),
      ),
    );
  }
}
