import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

class AppDialogComponent extends StatefulWidget {
  final String title;
  final String subTitle;
  final String image;
  final List<Widget>? buttons;

  const AppDialogComponent({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.image,
    this.buttons,
  }) : super(key: key);

  @override
  State<AppDialogComponent> createState() => _AppDialogComponentState();
}

class _AppDialogComponentState extends State<AppDialogComponent> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: AppTextStyle.whiteLargeMediumText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.subTitle,
              style: AppTextStyle.blackExtraSmallText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Image.asset(
              widget.image,
              height: 200,
            ),
            const SizedBox(height: 16),
            ...(widget.buttons ?? []),
          ],
        ),
      ),
    );
  }
}

class AppDefaultDialog extends AppDialogComponent {
  const AppDefaultDialog({
    Key? key,
    required String title,
    required String subTitle,
    required String image,
    List<Widget>? buttons,
  }) : super(
          key: key,
          title: title,
          subTitle: subTitle,
          image: image,
          buttons: buttons,
        );
}
