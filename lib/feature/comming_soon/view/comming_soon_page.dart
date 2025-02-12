import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/comming_soon/view/comming_soon_view.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/widget_on_progress_feature.dart';

class CommingSoonPage extends StatelessWidget {
  const CommingSoonPage(
    this.pageTitle, {
    this.customImage,
    this.customTitle,
    this.customDescription,
    super.key,
  });

  final String pageTitle;
  final String? customImage;
  final String? customTitle;
  final String? customDescription;

  static RouteSettings route() =>
      const RouteSettings(name: '/comming-soon-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        pageTitle,
      ),
      body: WidgetFeatureOnProgress(
        child: CommingSoonView(
          customImage: customImage,
          customTitle: customTitle,
          customDescription: customDescription,
        ),
      ),
    );
  }
}
