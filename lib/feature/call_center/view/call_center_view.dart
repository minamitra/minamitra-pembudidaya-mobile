import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_shimmer.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_encode.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/call_center/logic/call_center_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:url_launcher/url_launcher.dart';

class CallCenterView extends StatefulWidget {
  const CallCenterView({super.key});

  @override
  State<CallCenterView> createState() => _CallCenterViewState();
}

class _CallCenterViewState extends State<CallCenterView> {
  bool _hasCallSupport = false;

  @override
  void initState() {
    super.initState();
    canLaunchUrl(Uri(scheme: 'tel', path: '085227111102')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> header() {
      return [
        Text(
          'Hubungi Kami',
          style: appTextTheme(context)
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Jika Anda memiliki pertanyaan atau membutuhkan bantuan lebih lanjut mengenai aplikasi Mitra3M, Anda dapat menghubungi kami di:',
          style: appTextTheme(context)
              .bodySmall
              ?.copyWith(color: AppColor.neutral[500]),
        ),
      ];
    }

    Widget callCenterItem(
      IconData icon,
      String text,
      Function() onTap,
    ) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 16.0,
          ),
          decoration: BoxDecoration(
            color: AppColor.neutral[50],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: AppColor.primary[500],
              ),
              const SizedBox(width: 18.0),
              Expanded(
                child: Text(
                  text,
                  maxLines: 3,
                  style: appTextTheme(context)
                      .titleMedium
                      ?.copyWith(color: AppColor.primary[900]),
                ),
              ),
            ],
          ),
        ),
      );
    }

    List<Widget> callCenterActionItems(CallCenterState state) {
      if (state.status.isLoading) {
        return [
          const AppShimmer(
            65.0,
            double.infinity,
            8.0,
          ),
          const SizedBox(height: 18.0),
          const AppShimmer(
            65.0,
            double.infinity,
            8.0,
          ),
        ];
      }
      String cleanNumber =
          state.waNumber?.data?.value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
      List<String> splitter = cleanNumber.split('');
      splitter.removeAt(0);
      String withoutZero = splitter.join('');

      return [
        callCenterItem(
          Icons.phone_in_talk_rounded,
          '$cleanNumber (WhatsApp)',
          () async {
            if (!await launchUrl(
              Uri.parse('https://wa.me/+62$withoutZero'),
            )) {
              AppTopSnackBar(context).showDanger('Gagal memuat data');
              throw Exception(
                'Could not launch https://wa.me/+62$withoutZero',
              );
            }
          },
        ),
        const SizedBox(height: 18.0),
        callCenterItem(
          Icons.mail_rounded,
          state.email?.data?.value.handlingEmptyString() ?? '-',
          () async {
            Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: state.email?.data?.value.handlingEmptyString() ?? '-',
              query: encodeQueryParameters(<String, String>{
                'subject': 'Hallo admin Mitra 3M, saya ingin bertanya',
              }),
            );
            await launchUrl(emailLaunchUri);
          },
        ),
        const SizedBox(height: 18.0),
        callCenterItem(
          Icons.location_on_rounded,
          state.location?.data?.value.handlingEmptyString() ?? '-',
          () async {},
        ),
      ];
    }

    Widget callButton(CallCenterState state) {
      if (state.status.isLoading) {
        return const AppShimmer(
          55.0,
          double.infinity,
          8.0,
        );
      }

      String cleanNumber =
          state.waNumber?.data?.value?.replaceAll(RegExp(r'[^0-9]'), '') ?? '';
      return AppPrimaryFullButton(
        'Hubungi Admin',
        () async {
          final Uri launchUri = Uri(
            scheme: 'tel',
            path: cleanNumber,
          );

          if (!_hasCallSupport) {
            AppTopSnackBar(context)
                .showDanger('Perangkat tidak mendukung\npanggilan telepon');
            return;
          }

          await launchUrl(launchUri);
        },
        prefixIcon: const Icon(
          Icons.chat_rounded,
          color: AppColor.white,
        ),
      );
    }

    return BlocBuilder<CallCenterCubit, CallCenterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              const SizedBox(height: 18.0),
              ...header(),
              const SizedBox(height: 36.0),
              ...callCenterActionItems(state),
              const Spacer(),
              callButton(state),
              const SizedBox(height: 18.0),
            ],
          ),
        );
      },
    );
  }
}
