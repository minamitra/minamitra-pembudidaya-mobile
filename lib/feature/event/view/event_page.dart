import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event/view/event_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_history/view/event_history_page.dart';
import 'package:minamitra_pembudidaya_mobile/widget/view/widget_on_progress_feature.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  static RouteSettings route() => const RouteSettings(name: '/event-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Acara 3M',
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                AppTransition.pushTransition(
                  const EventHistoryPage(),
                  EventHistoryPage.route(),
                ),
              );
            },
            child: const Icon(
              Icons.history,
              color: AppColor.white,
            ),
          ),
          const SizedBox(width: 18.0),
        ],
      ),
      body: WidgetFeatureOnProgress(child: EventView()),
    );
  }
}
