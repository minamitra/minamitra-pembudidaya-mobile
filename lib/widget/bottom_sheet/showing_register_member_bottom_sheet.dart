import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bottom_sheet.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

Future showingRegisterMemberBottomSheet(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return AppBottomSheet(
        '',
        ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Image.asset(
              AppAssets.askProfileCheckImage,
              height: MediaQuery.sizeOf(context).height * 0.2,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Periksa Profil Anda',
              textAlign: TextAlign.center,
              style: appTextTheme(context).headlineSmall,
            ),
            const SizedBox(height: 6.0),
            Text(
              'Apakah anda yakin data akun anda sudah benar dan lengkap? Data profil anda akan digunakan dalam proses review data. Jika anda masih merasa kurang lengkap / yakin, silahkan klik button cek profil dibawah.',
              textAlign: TextAlign.center,
              style: appTextTheme(context).bodySmall,
            ),
            const SizedBox(height: 16.0),
            AppPrimaryFullButton(
              'Cek Profil',
              () {
                Navigator.of(context).pop('cek-profile');
              },
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: AppPrimaryOutlineButton(
                    'Batal',
                    () {
                      Navigator.of(context).pop('cancel');
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: AppPrimaryFullButton(
                    'Daftar',
                    () {
                      Navigator.of(context).pop('register');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        isNeedAppBar: false,
        height: MediaQuery.sizeOf(context).height * 0.6,
      );
    },
  );
}
