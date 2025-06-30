import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/balance/balance_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/home/home_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/literacy_information/literacy_information_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/point/point_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/product/product_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/logic/home_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/views/home_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/notification/view/notification_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/products/logics/products_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(
            HomeServiceImpl.create(),
            BalanceServiceImpl.create(),
            LiteracyInformationServiceImpl.create(),
            PointServiceImpl.create(),
          )..init(),
        ),
        // BlocProvider<ActivityCubit>(
        //   create: (context) =>
        //       ActivityCubit(PondServiceImpl.create())..init(limit: '1'),
        // ),
        BlocProvider(
          create: (context) => ProductsCubit(
            ProductServiceImpl.create(),
          )..getProducts(limit: '5'),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<HomeCubit, HomeState>(
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
          // BlocListener<ActivityCubit, ActivityState>(
          //   listener: (context, state) {
          //     if (state.status.isError) {
          //       if (state.errorMessage == 'TOKEN_EXPIRED') {
          //         RepositoryProvider.of<AuthenticationRepository>(context)
          //             .logout();
          //       } else {
          //         AppTopSnackBar(context).showDanger(state.errorMessage);
          //       }
          //     }
          //   },
          // ),
        ],
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Scaffold(
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
                      Navigator.of(context)
                          .push(
                        AppTransition.pushTransition(
                          const NotificationPage(),
                          NotificationPage.routeSettings(),
                        ),
                      )
                          .then((value) {
                        context.read<HomeCubit>().refreshNotif();
                      });
                    },
                    child: SizedBox(
                      width: state.isHasNotification ? 24.0 : 20.0,
                      height: state.isHasNotification ? 24.0 : 20.0,
                      child: Stack(
                        children: [
                          Image.asset(
                            AppAssets.bellIcon,
                            height: 20.0,
                            fit: BoxFit.cover,
                          ),
                          if (state.isHasNotification)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 10.0,
                                height: 10.0,
                                decoration: const BoxDecoration(
                                  color: AppColor.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              body: const HomeView(),
            );
          },
        ),
      ),
    );
  }
}
