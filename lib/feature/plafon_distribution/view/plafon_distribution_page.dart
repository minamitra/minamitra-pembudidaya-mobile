import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/plafon_distribution/plafon_distribution_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/logic/plafon_distribution_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/plafon_distribution/view/plafon_distribution_view.dart';

class PlafonDistributionPage extends StatelessWidget {
  const PlafonDistributionPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/plafon-distribution-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlafonDistributionCubit(PlafonDistributionServiceImpl.create())
            ..init(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Distribusi Plafon',
        ),
        body: const PlafonDistributionView(),
      ),
    );
  }
}
