import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_history/view/event_history_view.dart';

class EventHistoryPage extends StatelessWidget {
  const EventHistoryPage({super.key});

  static RouteSettings route() =>
      const RouteSettings(name: '/event-history-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        'Acara Saya',
      ),
      body: EventHistoryView(),
    );
  }
}
