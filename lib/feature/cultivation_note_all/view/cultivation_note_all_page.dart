import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_all/logic/cubit/cultivation_note_all_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_all/view/cultivation_note_all_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';

class CultivationNoteAllPage extends StatelessWidget {
  const CultivationNoteAllPage(this.pondCycleID, this.data, {super.key});

  final String pondCycleID;
  final List<CompanionNotesResponseData>? data;

  static const RouteSettings routeSettings =
      RouteSettings(name: '/cultivation-note-all-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CultivationNoteAllCubit(CycleServiceImpl.create())
        ..init(
          pondCycleID,
          data,
        ),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          "Catatan Pendamping",
        ),
        body: CultivationNoteAllView(data),
      ),
    );
  }
}
