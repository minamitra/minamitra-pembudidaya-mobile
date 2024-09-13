import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text_field.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/logic/profile_member_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/attachment/attachment_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/profile_member/view/biodata/biodata_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

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
        child: TabBarView(
          controller: _tabController,
          children: [
            BiodataView(),
            AttachmentView(),
          ],
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
