import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_all/view/cultivation_note_all_view.dart';

class CultivationNoteAllPage extends StatelessWidget {
  const CultivationNoteAllPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/cultivation-note-all-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Catatan Pendamping",
      ),
      body: CultivationNoteAllView(),
    );
  }
}
