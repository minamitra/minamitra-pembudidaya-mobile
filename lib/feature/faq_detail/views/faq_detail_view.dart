import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class FaqDetailView extends StatelessWidget {
  final String title;

  const FaqDetailView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Image.asset(
              AppAssets.questionIcon,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Pertanyaan',
              textAlign: TextAlign.start,
              style: appTextTheme(context).titleSmall?.copyWith(
                    color: AppColor.primary[600],
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.start,
          style: appTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Divider(
          color: AppColor.neutral[300],
          height: 48,
          thickness: 1,
        ),
        Row(
          children: [
            Image.asset(
              AppAssets.chatIcon,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Jawaban',
              textAlign: TextAlign.start,
              style: appTextTheme(context).titleSmall?.copyWith(
                    color: AppColor.primary[600],
                  ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam faucibus nisl mi, non iaculis ipsum maximus sit amet. Nullam aliquam diam et commodo consectetur. Fusce et mi euismod, imperdiet ligula id, posuere leo. Vivamus placerat libero sit amet condimentum sagittis. Cras sed consectetur ante. Ut eu sapien ut elit euismod interdum eu vel eros. Suspendisse elit urna, vulputate in venenatis id, dapibus cursus erat. Nullam nec mattis felis.',
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Vestibulum commodo pulvinar tortor. Aenean maximus purus a metus mollis, sed porta purus imperdiet. Sed aliquet dolor sed mauris semper, in aliquet mauris aliquet. Nam luctus urna vel mauris pulvinar, ac vulputate ipsum posuere. Curabitur eget vehicula massa. Sed augue mauris, gravida a pharetra quis, rutrum ut eros. Quisque ornare congue odio a pulvinar. Aliquam malesuada augue non ultrices facilisis.',
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam faucibus nisl mi, non iaculis ipsum maximus sit amet. Nullam aliquam diam et commodo consectetur. Fusce et mi euismod, imperdiet ligula id, posuere leo. Vivamus placerat libero sit amet condimentum sagittis. Cras sed consectetur ante. Ut eu sapien ut elit euismod interdum eu vel eros. Suspendisse elit urna, vulputate in venenatis id, dapibus cursus erat. Nullam nec mattis felis.',
          textAlign: TextAlign.start,
          style: appTextTheme(context).bodySmall,
        ),
      ],
    );
  }
}
