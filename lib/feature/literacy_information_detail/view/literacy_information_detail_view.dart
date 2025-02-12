import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/literacy_information_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information_detail/logic/literacy_information_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:share_plus/share_plus.dart';

class LiteracyInformationDetailView extends StatefulWidget {
  const LiteracyInformationDetailView(this.data, {super.key});

  final LiteracyInformationResponseData data;

  @override
  State<LiteracyInformationDetailView> createState() =>
      _LiteracyInformationDetailViewState();
}

class _LiteracyInformationDetailViewState
    extends State<LiteracyInformationDetailView> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Stack(
        children: [
          Container(
            color: AppColor.primary[800],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Hero(
                    tag: widget.data.imageUrl ?? '',
                    child: Image.network(
                      widget.data.imageUrl ??
                          'https://www.worldanimalprotection.ca/cdn-cgi/image/width=1280,format=auto/siteassets/shutterstock_1899421132.jpg',
                      height: 250.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  left: 18.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.0,
                  right: 18.0,
                  child: InkWell(
                    onTap: () {
                      Share.share(
                        'Yuk ikut gabung Mitra3M \nPakai kode berikut ini untuk dapatkan keuntungan menarik lainnya \n\n${widget.data.title}\n${widget.data.content}',
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.share_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget titleHeader(
      String title,
      String writer,
      String date,
    ) {
      return Column(
        children: [
          const SizedBox(height: 18.0),
          Text(
            title,
            textAlign: TextAlign.start,
            style: appTextTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Text(
                writer,
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.primary[600],
                    ),
              ),
              const SizedBox(width: 8.0),
              Icon(
                Icons.circle,
                color: AppColor.neutral[500],
                size: 2,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  date,
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.neutral[500],
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
        ],
      );
    }

    return BlocBuilder<LiteracyInformationDetailCubit,
        LiteracyInformationDetailState>(
      builder: (context, state) {
        return ListView(
          children: [
            header(),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              children: [
                titleHeader(
                  widget.data.title?.handlingEmptyString() ?? '',
                  widget.data.authorName?.handlingEmptyString() ?? '',
                  AppConvertDateTime()
                      .dmyName(widget.data.createDatetime ?? DateTime.now()),
                ),
                state.status.isLoading
                    ? SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.5,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : HtmlWidget(
                        state.data?.content.handlingEmptyString() ?? '',
                        textStyle: appTextTheme(context).bodySmall,
                      ),
                const SizedBox(height: 24.0),
              ],
            ),
          ],
        );
      },
    );
  }
}
