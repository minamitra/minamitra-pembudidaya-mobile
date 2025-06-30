import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cycle/cycle_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_detail/view/cultivation_note_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/logic/cultivation_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/monitoring/repository/companion_notes_response.dart';

class CultivationNoteDetailPage extends StatelessWidget {
  const CultivationNoteDetailPage({
    this.data,
    this.id,
    super.key,
  });

  final CompanionNotesResponseData? data;
  final String? id;

  static const RouteSettings routeSettings =
      RouteSettings(name: '/cultivation-note-detail-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CultivationCubit(
        CycleServiceImpl.create(),
        data: data,
      )..setUpData(id: id),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Detail Catatan Pendamping',
        ),
        body: CultivationNoteDetailView(),
      ),
    );
  }
}
