import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_datetime.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_convert_string.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/repositories/delivery_status_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/vertical_line_stepper/repositories/stepper_model.dart';
import 'package:minamitra_pembudidaya_mobile/feature/vertical_line_stepper/view/vertical_line_stepper_page.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class DetailDeliveryPage extends StatelessWidget {
  const DetailDeliveryPage(this.deliveryNumber, this.data, {super.key});

  static RouteSettings routeSettings() =>
      const RouteSettings(name: '/detail-delivery-page');

  final String deliveryNumber;
  final DeliveryStatusResponse data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Informasi Pengiriman',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'ID Pesanan',
                    style: appTextTheme(context)
                        .bodySmall
                        ?.copyWith(color: const Color(0xFF6B7280)),
                  ),
                ),
                Text(
                  deliveryNumber,
                  style: appTextTheme(context)
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: deliveryNumber))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$deliveryNumber Berhasil disalin'),
                        ),
                      );
                    });
                  },
                  child: Icon(
                    Icons.copy,
                    size: 16.0,
                    color: AppColor.primary[500],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColor.neutral[100],
            thickness: 18.0,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Status Pengiriman',
                    style: appTextTheme(context)
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.data?.length,
                  itemBuilder: (context, index) {
                    return VerticalLineStepperWidget(
                      StepperModel(
                        title:
                            data.data?[index].note.handlingEmptyString() ?? '-',
                        subTitle: AppConvertDateTime().ddmmyyyyhhmm(
                          data.data?[index].datetime ?? DateTime.now(),
                        ),
                        isCompleted: true,
                        isFirst: index == 0,
                        isLast:
                            index != 0 ? index == data.data!.length - 1 : false,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
