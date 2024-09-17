import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_card.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq/repositories/faq_dummy.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq_detail/views/faq_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class FaqView extends StatefulWidget {
  const FaqView({super.key});

  @override
  State<FaqView> createState() => _FaqViewState();
}

class _FaqViewState extends State<FaqView> {
  final _searchController = TextEditingController();

  Widget searchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColor.neutral[200]!),
      ),
      height: 40,
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.search,
        style: AppTextStyle.blackSmallText,
        decoration: InputDecoration(
          isCollapsed: true,
          hintStyle: AppTextStyle.blackSmallText,
          hintText: 'Cari pertanyaan',
          prefixIcon: const Icon(
            Icons.search,
            color: AppColor.black,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          fillColor: AppColor.white,
        ),
      ),
    );
  }

  Widget itemCard(String text) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(AppTransition.pushTransition(
          FaqDetailPage(text),
          FaqDetailPage.routeSettings(),
        ));
      },
      child: AppDefaultCard(
        isShadow: false,
        borderColor: AppColor.neutral[200],
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: appTextTheme(context).bodySmall?.copyWith(
                      color: AppColor.primary[900],
                    ),
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Widget listCard() {
    return Expanded(
      child: ListView.separated(
        itemCount: listFaqDummy.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return itemCard(listFaqDummy[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          searchField(),
          const SizedBox(height: 16),
          listCard(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
