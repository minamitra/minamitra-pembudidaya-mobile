import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/dashboard/dashboard_bottom_nav_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/profile/profile_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/view/activity_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/components/dashboard_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/dashboard/logic/dashboard_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/views/home_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile/view/profile_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction/views/transaction_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/waiting_global_page.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: '/dashboard');

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Widget> currentScrenList = const [
    HomePage(),
    TransactionPage(),
    ActivityPage(),
    ProfilePage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appCloudMessaging.setFirebaseCloudMessagingHandler(context);
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocBuilder<DashboardBottomNavCubit, int>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => DashboardCubit(ProfileServiceImpl.create()),
          child: BlocListener<DashboardCubit, DashboardState>(
            listener: (context, state) {
              if (state.status.isShowDialogLoading) {
                AppDialog().showLoadingDialog(context, dialog);
              }

              if (state.status.isHideDialogLoading) {
                dialog.hide();
              }

              if (state.status.isError) {
                if (state.errorMessage == 'TOKEN_EXPIRED') {
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }

              if (state.status.isSuccessSubmit) {
                AppTopSnackBar(context)
                    .showSuccess('Berhasil mengajukan member');
                Navigator.of(context).push(
                  AppTransition.pushTransition(
                    const WaitingGlobalPage(
                      'Dalam verifikasi',
                      'Terimakasih telah melakukan pendaftaran sebagai anggota. Selanjutnya kami akan melakukan proses verifikasi terlebih dahulu atas data yang anda submit. Jika diperlukan kami akan mengontak anda dan pastikan nomor telp/email/alamat dapat dihubungi. Terimakasih',
                      '*Proses verifikasi setidaknya memakan waktu 7 hari kerja',
                    ),
                    WaitingGlobalPage.routeSettings(),
                  ),
                );
              }
            },
            child: Scaffold(
              body: PageStorage(
                bucket: bucket,
                child: currentScrenList[state],
              ),
              bottomNavigationBar: DashboardBottomNavigationBar(
                state,
                (index) {
                  context.read<DashboardBottomNavCubit>().changeIndex(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
