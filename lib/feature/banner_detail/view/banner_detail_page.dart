import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/repositories/home_response.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerDetailPage extends StatefulWidget {
  const BannerDetailPage(this.data, {super.key});

  final HomeResponseData data;

  static const RouteSettings routeSettings =
      RouteSettings(name: '/banner-detail-page');

  @override
  State<BannerDetailPage> createState() => _BannerDetailPageState();
}

class _BannerDetailPageState extends State<BannerDetailPage> {
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
                InkWell(
                  onTap: () {
                    showImageViewer(
                      context,
                      Image.network(
                        widget.data.imageUrl ?? '',
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 250.0,
                            width: double.infinity,
                            child: Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ).image,
                      immersive: false,
                      useSafeArea: true,
                      swipeDismissible: true,
                      doubleTapZoomable: true,
                      backgroundColor: Colors.black.withOpacity(0.7),
                    );
                  },
                  child: Center(
                    child: Image.network(
                      widget.data.imageUrl ?? '',
                      height: 250.0,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 250.0,
                          width: double.infinity,
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
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
              ],
            ),
          ),
        ],
      );
    }

    Widget titleHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18.0),
          Text(
            widget.data.title.handlingEmptyString(),
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
                AppConvertDateTime()
                    .dmyName(widget.data.startDatetime ?? DateTime.now()),
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.neutral[500],
                    ),
              ),
              const SizedBox(width: 8.0),
              Text(
                '-',
                textAlign: TextAlign.start,
                style: appTextTheme(context).titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.neutral[500],
                    ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  AppConvertDateTime()
                      .dmyName(widget.data.endDatetime ?? DateTime.now()),
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

    return Scaffold(
      body: ListView(
        children: [
          header(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleHeader(),
                Text(
                  widget.data.desc.handlingEmptyString(),
                  textAlign: TextAlign.start,
                  style: appTextTheme(context).bodySmall,
                ),
                const SizedBox(height: 18.0),
                InkWell(
                  onTap: () async {
                    if (!await launchUrl(
                      Uri.parse(widget.data.linkUrl ?? ''),
                    )) {
                      AppTopSnackBar(context).showDanger('Gagal memuat data');
                      throw Exception(
                        'Could not launch ${widget.data.linkUrl ?? ''}',
                      );
                    }
                  },
                  child: Text(
                    widget.data.linkUrl.handlingEmptyString(),
                    textAlign: TextAlign.start,
                    style: appTextTheme(context).bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.primary[600],
                          color: AppColor.primary[600],
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
