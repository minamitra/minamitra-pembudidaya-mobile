import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AppDialogComponent extends StatefulWidget {
  final String title;
  final String subTitle;
  final String? image;
  final List<Widget>? buttons;

  const AppDialogComponent({
    super.key,
    required this.title,
    required this.subTitle,
    this.image,
    this.buttons,
  });

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
              style: appTextTheme(context).headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.subTitle,
              style: appTextTheme(context).bodySmall,
              textAlign: TextAlign.center,
            ),
            if (widget.image != null) ...[
              const SizedBox(height: 16),
              Image.asset(
                widget.image!,
                height: 200,
              ),
            ],
            const SizedBox(height: 24),
            Row(
              children: [
                ...(widget.buttons ?? []),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppDefaultDialog extends AppDialogComponent {
  const AppDefaultDialog({
    super.key,
    required super.title,
    required super.subTitle,
    super.image,
    super.buttons,
  });
}

class AppDialog {
  void showLoadingDialog(
    BuildContext context,
    SimpleFontelicoProgressDialog dialog,
  ) {
    dialog.show(
      message: "Loading ...",
      type: SimpleFontelicoProgressDialogType.iphone,
      horizontal: false,
      hideText: false,
      indicatorColor: AppColor.primary,
      radius: 8.0,
      backgroundColor: Colors.white.withOpacity(0.25),
    );
  }

  static defaultDialog(
    BuildContext context,
    String title, {
    required Widget child,
    bool isDynamicHeight = true,
  }) {
    Widget header() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          color: AppColor.primary[50],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: appTextTheme(context).bodyMedium,
            )),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: AppColor.primary,
              ),
            )
          ],
        ),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      scrollable: isDynamicHeight ? false : true,
      insetPadding: const EdgeInsets.all(16.0),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Container(
        height: isDynamicHeight ? null : MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: isDynamicHeight ? MainAxisSize.min : MainAxisSize.min,
          children: [
            header(),
            const SizedBox(height: 24.0),
            isDynamicHeight
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: child,
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: child,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
