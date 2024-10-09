import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/image/multiple_image_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cdn/cdn_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed/feed_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/repositories/pond_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_first_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_second_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/logic/add_pond_third_step_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/add_pond/view/add_pond_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

enum BehaviourPage {
  editPond,
  addNewCycle,
  addNewPond,
}

class AddPondPage extends StatelessWidget {
  const AddPondPage({
    this.behaviourPage = BehaviourPage.addNewPond,
    this.pondID,
    this.pondData,
    super.key,
  });

  final BehaviourPage behaviourPage;
  final String? pondID;
  final PondResponseData? pondData;

  static RouteSettings routeSettings() {
    return const RouteSettings(name: '/add-pond-first-step-page');
  }

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AddPondCubit(
            RefServiceImpl.create(),
            PondServiceImpl.create(),
            FeedServiceImpl.create(),
          )..init(),
        ),
        BlocProvider(create: (context) => MultipleImageCubit()),
        BlocProvider(create: (context) => AddPondFirstStepCubit()),
        BlocProvider(
          create: (context) {
            return pondData != null
                ? (AddPondSecondStepCubit(
                    RefServiceImpl.create(),
                    CdnServiceImpl.create(),
                  )..initWithExistData(
                    provinceId: pondData!.addressProvinceId!,
                    provinceName: pondData!.addressProvinceName!,
                    districtId: pondData!.addressCityId!,
                    districtName: pondData!.addressCityName!,
                    subDistrictId: pondData!.addressSubdistrictId!,
                    subDistrictName: pondData!.addressSubdistrictName!,
                    villageId: pondData!.addressVillageId!,
                    villageName: pondData!.addressVillageName!,
                    latitude: pondData!.addressLatitude ?? "",
                    longitude: pondData!.addressLongitude ?? "",
                  ))
                : (AddPondSecondStepCubit(
                    RefServiceImpl.create(),
                    CdnServiceImpl.create(),
                  )..init());
          },
        ),
        BlocProvider(
            create: (context) =>
                AddPondThirdStepCubit(FeedServiceImpl.create())..init()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddPondCubit, AddPondState>(
            listener: (context, state) {
              if (state.status.isShowDialogLoading) {
                AppDialog().showLoadingDialog(context, dialog);
              }

              if (state.status.isHideDialogLoading) {
                dialog.hide();
              }

              if (state.status.isError) {
                if (state.errorMessage == "TOKEN_EXPIRED") {
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .logout();
                } else {
                  AppTopSnackBar(context).showDanger(state.errorMessage);
                }
              }

              if (state.status.isSuccessSubmit) {
                if (behaviourPage == BehaviourPage.addNewPond) {
                  AppTopSnackBar(context)
                      .showSuccess("Berhasil Membuat\nKolam Baru");
                  Navigator.of(context).pop("refresh");
                } else if (behaviourPage == BehaviourPage.addNewCycle) {
                  AppTopSnackBar(context)
                      .showSuccess("Berhasil Membuat\nSiklus Baru");
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop("refresh");
                } else if (behaviourPage == BehaviourPage.editPond) {
                  AppTopSnackBar(context).showSuccess("Berhasil Edit\nKolam");
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop("refresh");
                }
              }
            },
          )
        ],
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            "Tambah Kolam",
            onBackButtonPressed: () {
              Navigator.of(context).pop();
            },
          ),
          body: BlocBuilder<AddPondCubit, AddPondState>(
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return AddPondView(
                behaviourPage,
                pondID: pondID,
                pondData: pondData,
              );
            },
          ),
        ),
      ),
    );
  }
}
