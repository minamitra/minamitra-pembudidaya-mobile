import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_animated_size.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_button.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_shadow.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_first_step/add_pond_first_step_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_second_step/add_pond_second_step_view.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_third_step/add_pond_third_step_view.dart';
import 'package:minamitra_pembudidaya_mobile/main.dart';

class AddPondView extends StatefulWidget {
  const AddPondView(this.behaviourPage,
      {this.pondID, this.pondData, super.key});

  final BehaviourPage behaviourPage;
  final String? pondID;
  final PondResponseData? pondData;

  @override
  State<AddPondView> createState() => _AddPondViewState();
}

class _AddPondViewState extends State<AddPondView> {
  PageController pageController = PageController(initialPage: 0);
  final GlobalKey<FormState> formFirstStepKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formSecondStepKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formThirdStepKey = GlobalKey<FormState>();

  @override
  void initState() {
    // pageController.jumpToPage(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget stepSection(
      int index,
      String title,
      bool isActive,
      bool isReached, {
      int maxLenght = 3,
    }) {
      return Row(
        children: [
          SizedBox(width: index > 1 ? 8.0 : 0.0),
          Container(
            height: 28.0,
            width: 28.0,
            decoration: BoxDecoration(
              color: isActive
                  ? appColorScheme(context).primary
                  : isReached
                      ? AppColor.green[500]
                      : AppColor.white,
              shape: BoxShape.circle,
              boxShadow: AppBoxShadow().normal,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: appTextTheme(context).labelLarge?.copyWith(
                      color: isActive
                          ? AppColor.white
                          : isReached
                              ? AppColor.white
                              : appColorScheme(context).primary,
                    ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            title,
            style: appTextTheme(context).labelLarge?.copyWith(
                  color: isActive
                      ? appColorScheme(context).primary
                      : isReached
                          ? AppColor.green[500]
                          : AppColor.black,
                ),
          ),
          SizedBox(width: index < maxLenght ? 8.0 : 0),
          if (index < maxLenght)
            Expanded(
              child: Divider(
                color: isReached ? AppColor.green[500] : AppColor.neutral[400],
              ),
            ),
        ],
      );
    }

    Widget currentStep() {
      return BlocBuilder<AddPondCubit, AddPondState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            color: Colors.transparent,
            child: widget.behaviourPage == BehaviourPage.addNewPond
                ? Row(
                    children: [
                      Expanded(
                        child: stepSection(
                          1,
                          "Kolam",
                          state.index == 0,
                          state.index > 0,
                        ),
                      ),
                      Expanded(
                        child: stepSection(
                          2,
                          "Lokasi",
                          state.index == 1,
                          state.index > 1,
                        ),
                      ),
                      stepSection(
                        3,
                        "Siklus",
                        state.index == 2,
                        false,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: stepSection(
                          1,
                          "Kolam",
                          state.index == 0,
                          state.index > 0,
                        ),
                      ),
                      stepSection(
                        2,
                        "Lokasi",
                        state.index == 1,
                        state.index > 1,
                        maxLenght: 2,
                      ),
                    ],
                  ),
          );
        },
      );
    }

    Widget body() {
      if (BehaviourPage.addNewCycle == widget.behaviourPage) {
        return AddPondThirdStepView(
          pageController,
          widget.behaviourPage,
          pondID: widget.pondID,
        );
      }

      if (BehaviourPage.editPond == widget.behaviourPage) {
        return PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AddPondFirstStepView(
              pageController,
              pondData: widget.pondData,
            ),
            AddPondSecondStepView(
              pageController,
              pondData: widget.pondData,
            ),
          ],
        );
      }

      return PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          AddPondFirstStepView(pageController),
          AddPondSecondStepView(pageController),
          AddPondThirdStepView(
            pageController,
            widget.behaviourPage,
          ),
        ],
      );
    }

    Widget bottomButton() {
      return BlocBuilder<AddPondCubit, AddPondState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                if (state.index > 0)
                  Expanded(
                    child: AppAnimatedSize(
                      isShow: state.index > 0,
                      child: AppPrimaryOutlineFullButton(
                        "Kembali",
                        () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          context
                              .read<AddPondCubit>()
                              .changeStep(state.index - 1);
                        },
                      ),
                    ),
                  ),
                if (state.index > 0) const SizedBox(width: 16.0),
                Expanded(
                  child: AppAnimatedSize(
                    isShow: true,
                    child: AppPrimaryFullButton(
                      state.index == 2 ? "Simpan" : "Selanjutnya",
                      () {
                        state.index == 2
                            ? null
                            : pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                        state.index == 2
                            ? null
                            : context
                                .read<AddPondCubit>()
                                .changeStep(state.index + 1);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        children: [
          if (widget.behaviourPage != BehaviourPage.addNewCycle)
            const SizedBox(height: 18.0),
          if (widget.behaviourPage != BehaviourPage.addNewCycle) currentStep(),
          Expanded(child: body()),
          // bottomButton(),
        ],
      ),
    );
  }
}
