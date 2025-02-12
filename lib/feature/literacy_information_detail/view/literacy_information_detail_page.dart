import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/repositories/literacy_information_response.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/literacy_information/literacy_information_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information_detail/logic/literacy_information_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/literacy_information_detail/view/literacy_information_detail_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';
import 'package:share_plus/share_plus.dart';

class LiteracyInformationDetailPage extends StatelessWidget {
  const LiteracyInformationDetailPage(this.data, {super.key});

  static RouteSettings settings =
      const RouteSettings(name: '/literacy-information-detail-page');

  final LiteracyInformationResponseData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LiteracyInformationDetailCubit(
        LiteracyInformationServiceImpl.create(),
      )..init(data.id ?? ''),
      child: Scaffold(
        body: LiteracyInformationDetailView(data),
      ),
    );
  }
}
