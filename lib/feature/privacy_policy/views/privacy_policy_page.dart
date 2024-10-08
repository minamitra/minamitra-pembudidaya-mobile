import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/term_condition/term_condition_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/privacy_policy/logics/privacy_policy_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/privacy_policy/views/privacy_policy_view.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const RouteSettings routeSettings =
      RouteSettings(name: '/privacy-policy-page');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appDefaultAppBar(
        context,
        "Kebijakan Privasi",
      ),
      body: BlocProvider(
        create: (context) => PrivacyPolicyCubit(
          TermConditionServiceImpl.create(),
        )..getPrivacyPolicy(),
        child: const PrivacyPolicyView(),
      ),
    );
  }
}
