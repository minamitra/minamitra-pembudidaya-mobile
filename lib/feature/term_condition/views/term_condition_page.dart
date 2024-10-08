import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/term_condition/term_condition_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/term_condition/logics/term_condition_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/term_condition/views/term_condition_view.dart';

class TermConditionPage extends StatelessWidget {
  const TermConditionPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/term-condition-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Syarat dan Ketentuan",
      ),
      body: BlocProvider(
        create: (context) => TermConditionCubit(
          TermConditionServiceImpl.create(),
        )..getTermCondition(),
        child: const TermConditionView(),
      ),
    );
  }
}
