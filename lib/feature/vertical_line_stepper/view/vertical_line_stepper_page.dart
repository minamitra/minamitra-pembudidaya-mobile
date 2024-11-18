import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/vertical_line_stepper/repositories/stepper_model.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:timeline_tile/timeline_tile.dart';

class VerticalLineStepperWidget extends StatelessWidget {
  const VerticalLineStepperWidget(this.stepper, {super.key});

  final StepperModel stepper;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: '/vertical-line-stepper-page');

  @override
  Widget build(BuildContext context) {
    Widget bodyStepper(
      String title,
      String subTitle,
      bool isActive, {
      bool isFirst = false,
      bool isLast = false,
    }) {
      return TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.0,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: const LineStyle(color: AppColor.secondary),
        afterLineStyle: LineStyle(
          color: isActive ? AppColor.secondary : AppColor.neutral[200]!,
        ),
        indicatorStyle: const IndicatorStyle(
          indicatorXY: 0.0,
          width: 40,
          height: 18,
          drawGap: true,
          padding: EdgeInsets.all(8),
          indicator: Icon(
            Icons.check_circle,
            color: Color(0xFF0EA5E9),
          ),
        ),
        endChild: Container(
          constraints: const BoxConstraints(minHeight: 80),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              Text(
                title,
                style:
                    appTextTheme(context).titleSmall?.copyWith(fontSize: 16.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                subTitle,
                style: appTextTheme(context)
                    .bodySmall
                    ?.copyWith(color: AppColor.neutral[400]),
              ),
            ],
          ),
        ),
      );
    }

    return bodyStepper(
      stepper.title,
      stepper.subTitle,
      stepper.isCompleted,
      isFirst: stepper.isFirst,
      isLast: stepper.isLast,
    );
  }
}
