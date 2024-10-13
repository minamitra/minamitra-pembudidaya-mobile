import 'package:flutter/material.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_detail/view/cultivation_note_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';

class CultivationNoteDetailPage extends StatelessWidget {
  const CultivationNoteDetailPage(this.data, {super.key});

  final CompanionNotesResponseData data;

  static const RouteSettings routeSettings =
      RouteSettings(name: '/cultivation-note-detail-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Detail Catatan Pendamping",
      ),
      body: CultivationNoteDetailView(data),
    );
  }
}
