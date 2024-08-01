import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

PreferredSizeWidget appDefaultAppBar(
  BuildContext context,
  String title, {
  bool needBackButton = true,
  Color backButtonColor = AppColor.white,
  List<Widget>? actions,
  Widget? customTitle,
  PreferredSizeWidget? bottom,
  Color bgColor = AppColor.white,
  Function()? onBackButtonPressed,
  Widget? flexibleSpace,
  bool isCenterTitle = false,
}) {
  return AppBar(
    title: customTitle ??
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.whiteExtraLargeMediumText,
          textAlign: TextAlign.left,
        ),
    centerTitle: isCenterTitle,
    backgroundColor: bgColor,
    titleSpacing: 0,
    elevation: 0,
    leading: needBackButton
        ? IconButton(
            onPressed: onBackButtonPressed ??
                () {
                  Navigator.pop(context);
                },
            icon: const Icon(Icons.arrow_back_ios),
            color: backButtonColor,
          )
        : null,
    actions: actions,
    bottom: bottom,
    flexibleSpace: flexibleSpace,
    scrolledUnderElevation: 0,
  );
}

Widget appSliverDefaultAppBar({
  String? titleText,
  Widget? customAppBarTitle,
  List<Widget>? actionsIcon,
  bool automaticallyImplyLeading = false,
  bool pinnedAppBar = true,
  bool floatingAppBar = false,
  bool snapAppBar = false,
  double? expandedHeight,
  Widget? flexibleSpaceTitle,
  bool centerTitleFlexibleCard = true,
  Widget? flexibleCardWidget,
  double? customToolbarHeight,
  double elevation = 1.5,
}) {
  Widget? _appBarTitle() {
    return titleText != null
        ? Text(titleText, style: AppTextStyle.whiteMediumText)
        : null;
  }

  return SliverAppBar(
    title: customAppBarTitle ?? _appBarTitle(),
    actions: actionsIcon,
    elevation: elevation,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: automaticallyImplyLeading,
    pinned: pinnedAppBar,
    floating: floatingAppBar,
    snap: snapAppBar,
    expandedHeight: expandedHeight,
    toolbarHeight: customToolbarHeight ?? kToolbarHeight,
    flexibleSpace: FlexibleSpaceBar(
      title: flexibleSpaceTitle,
      centerTitle: centerTitleFlexibleCard,
      background: flexibleCardWidget,
    ),
  );
}
