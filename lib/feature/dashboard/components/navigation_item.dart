import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem(this.callback, this.active, this.img, this.label,
      {Key? key})
      : super(key: key);

  final VoidCallback callback;
  final bool active;
  final String img;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Image.asset(
            img,
            height: 24.0,
            color: active ? AppColor.primary : AppColor.black,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 4),
          active
              ? Text(label,
                  style: AppTextStyle.primaryDoubleExtraSmallMediumText)
              : Text(label,
                  style: AppTextStyle.blackDoubleExtraSmallMediumText),
        ],
      ),
    );
  }
}
