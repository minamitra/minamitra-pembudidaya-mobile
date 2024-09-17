import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AppBottomSheet extends StatelessWidget {
  final String _title;
  final Widget _body;
  final double height;
  final List<Widget> actions;

  const AppBottomSheet(
    this._title,
    this._body, {
    this.height = 300,
    this.actions = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 4.0,
              decoration: BoxDecoration(
                color: AppColor.black[300],
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _title,
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ...actions,
              ],
            ),
          ),
          Divider(
            color: AppColor.neutral[300],
            thickness: 0.5,
            height: 32,
          ),
          Expanded(child: _body),
        ],
      ),
    );
  }
}

class AppCustomBottomSheet extends StatelessWidget {
  final String _title;
  final Widget _body;
  final double height;
  final Function() onMenuTap;

  const AppCustomBottomSheet(
    this._title,
    this._body,
    this.onMenuTap, {
    this.height = 300,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 16.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: 3.0,
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    _title,
                    style: AppTextStyle.whiteLargeBoldText,
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: onMenuTap,
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.add,
                        size: 24,
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColor.primary,
            height: 32,
          ),
          Expanded(child: _body),
        ],
      ),
    );
  }
}

Future showDeleteBottomSheet(
  BuildContext context, {
  required String title,
  required String descriptions,
  required Function() onTapDelete,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (modalContext) {
      return AppBottomSheet(
        title,
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.red[50],
                ),
                child: Icon(
                  Icons.delete_outline_rounded,
                  color: AppColor.red[500],
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                descriptions,
                textAlign: TextAlign.center,
                style: appTextTheme(context).titleSmall?.copyWith(
                      color: AppColor.neutral[500],
                    ),
              ),
              const SizedBox(height: 24.0),
              AppDividerSmall(),
              const SizedBox(height: 18.0),
              AppDangerFullButton(context, "Ya Hapus Permanen", onTapDelete),
              const SizedBox(height: 18.0),
              AppWhiteFullButton(
                "Batalkan",
                () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.5,
      );
    },
  );
}
