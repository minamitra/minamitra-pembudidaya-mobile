import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/public/public_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq_detail/logic/faq_detail_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/faq_detail/views/faq_detail_view.dart';

class FaqDetailPage extends StatelessWidget {
  final String id;
  final String title;

  const FaqDetailPage(
    this.id,
    this.title, {
    super.key,
  });

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/faq-detail-page');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqDetailCubit(PublicServiceImpl.create())..init(id),
      child: Scaffold(
        appBar: appDefaultAppBar(context, 'Detail FAQ'),
        body: FaqDetailView(title),
      ),
    );
  }
}
