import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/logic/profile_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/attachment/attachment_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/biodata/biodata_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ProfileMemberView extends StatefulWidget {
  const ProfileMemberView({super.key});

  @override
  State<ProfileMemberView> createState() => _ProfileMemberViewState();
}

class _ProfileMemberViewState extends State<ProfileMemberView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      context.read<ProfileMemberCubit>().changeTabIndex(_tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    Widget tabBar() {
      return Container(
        height: 60,
        decoration: BoxDecoration(color: AppColor.neutral[50]),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColor.primary,
          indicatorWeight: 2.5,
          padding: EdgeInsets.zero,
          labelColor: AppColor.primary,
          unselectedLabelColor: AppColor.neutral[400],
          labelStyle:
              appTextTheme(context).titleMedium?.copyWith(fontSize: 14.0),
          unselectedLabelStyle:
              appTextTheme(context).bodySmall?.copyWith(fontSize: 14.0),
          labelPadding: const EdgeInsets.all(0),
          isScrollable: false,
          tabs: const [
            Tab(text: 'Personal'),
            Tab(text: 'Lampiran'),
          ],
        ),
      );
    }

    Widget bodyTab() {
      return Expanded(
        child: BlocConsumer<ProfileMemberCubit, ProfileMemberState>(
          listener: (context, state) {
            if (state.status.isShowDialogLoading) {
              AppDialog().showLoadingDialog(context, dialog);
            }

            if (state.status.isHideDialogLoading) {
              dialog.hide();
            }

            if (state.status.isError) {
              if (state.errorMessage == "TOKEN_EXPIRED") {
                RepositoryProvider.of<AuthenticationRepository>(context)
                    .logout();
              } else {
                AppTopSnackBar(context).showDanger(state.errorMessage);
              }
            }
          },
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status.isLoaded) {
              return TabBarView(
                controller: _tabController,
                children: [
                  BiodataView(state.profile!),
                  AttachmentView(state.profile!),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      );
    }

    return Column(
      children: [
        tabBar(),
        bodyTab(),
      ],
    );
  }
}
