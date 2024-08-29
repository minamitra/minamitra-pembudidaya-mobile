import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AppBottomSheet extends StatelessWidget {
  final String _title;
  final Widget _body;
  final double height;

  const AppBottomSheet(
    this._title,
    this._body, {
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
