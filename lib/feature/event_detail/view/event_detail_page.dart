import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_detail/repositories/event_type.dart';
import 'package:minamitra_pembudidaya_mobile/feature/event_detail/view/event_detail_view.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({this.eventType = EventType.unregistered, super.key});

  final EventType eventType;

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/event-detail-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EventDetailView(eventType),
    );
  }
}
