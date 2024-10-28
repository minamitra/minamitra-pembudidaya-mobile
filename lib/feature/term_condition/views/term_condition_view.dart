import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/term_condition/logics/term_condition_cubit.dart';

class TermConditionView extends StatelessWidget {
  const TermConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TermConditionCubit, TermConditionState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status.isLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: HtmlWidget(
                state.termCondition!.value!,
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
