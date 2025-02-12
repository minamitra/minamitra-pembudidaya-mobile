import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/literacy_information/literacy_information_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information/logic/literacy_information_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information/views/literacy_information_view.dart';

class LiteracyInformationPage extends StatelessWidget {
  const LiteracyInformationPage({super.key});

  static RouteSettings settings =
      const RouteSettings(name: '/literacy-information-page');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LiteracyInformationCubit(LiteracyInformationServiceImpl.create())
            ..init(),
      child: Scaffold(
        appBar: appDefaultAppBar(
          context,
          'Literasi dan Informasi',
        ),
        body: LiteracyInformationView(),
      ),
    );
  }
}
