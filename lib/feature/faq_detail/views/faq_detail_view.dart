import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq_detail/logic/faq_detail_cubit.dart';
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
        BlocBuilder<FaqDetailCubit, FaqDetailState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return Text(
              state.faqDetailData?.answer.handlingEmptyString() ?? '-',
              textAlign: TextAlign.start,
              style: appTextTheme(context).bodySmall,
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
