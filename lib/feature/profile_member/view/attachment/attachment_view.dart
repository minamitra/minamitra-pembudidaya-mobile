import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_divider.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AttachmentView extends StatefulWidget {
  const AttachmentView({super.key});

  @override
  State<AttachmentView> createState() => _AttachmentViewState();
}

class _AttachmentViewState extends State<AttachmentView> {
  @override
  Widget build(BuildContext context) {
    Widget profilePhoto() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Foto Profil",
            style: appTextTheme(context).titleSmall,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: 100.0,
            height: 100.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.profileImageDummy),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    }

    List<Widget> identityPhoto() {
      return [
        Text(
          "Foto KTP",
          style: appTextTheme(context).titleSmall,
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          height: 170.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColor.neutral[300]!),
          ),
          child: Center(
            child: Icon(
              Icons.photo_library_outlined,
              color: AppColor.neutral[200],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Unggah file .jpg, .jpeg, .png, .img, .pdf ukuran maks 2MB",
          style: appTextTheme(context)
              .labelLarge
              ?.copyWith(color: AppColor.neutral[500]),
        )
      ];
    }

    List<Widget> identityMemberPhoto() {
      return [
        Text(
          "Kartu E-Kusuka",
          style: appTextTheme(context).titleSmall,
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          height: 220.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(
              image: AssetImage(AppAssets.memberCardDummyImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        AppDividerSmall(),
      ];
    }

    return ListView(
      padding: const EdgeInsets.all(18.0),
      children: [
        profilePhoto(),
        const SizedBox(height: 18.0),
        ...identityPhoto(),
        const SizedBox(height: 18.0),
        ...identityMemberPhoto(),
        AppPrimaryOutlineButton(
          "+ Tambah Lampiran Lainnya",
          () {},
        ),
        const SizedBox(height: 36.0),
      ],
    );
  }
}
