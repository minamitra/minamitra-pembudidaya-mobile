import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_bar.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_dialog.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/delivery_address/delivery_address_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/ref/ref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';
import 'package:minamitra_pembudidaya_mobile/feature/address_member/repositories/member_address_response.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_member_address/logic/detail_member_address_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/detail_member_address/view/detail_member_address_view.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class DetailMemberAddressPage extends StatelessWidget {
  const DetailMemberAddressPage({
    super.key,
    this.existData,
  });

  final MemberAddressResponseData? existData;

  static RouteSettings routeSettings() =>
      const RouteSettings(name: '/detail-member-address-page');

  @override
  Widget build(BuildContext context) {
    final SimpleFontelicoProgressDialog dialog =
        SimpleFontelicoProgressDialog(context: context);

    return BlocProvider(
      create: (context) => existData == null
          ? (DetailMemberAddressCubit(
              RefServiceImpl.create(),
              DeliveryAddressServiceImpl.create(),
            )..init())
          : (DetailMemberAddressCubit(
              RefServiceImpl.create(),
              DeliveryAddressServiceImpl.create(),
            )..initWithExistData(
              provinceId: existData?.provinceId ?? '0',
              provinceName: existData?.provinceName ?? '',
              districtId: existData?.cityId ?? '0',
              districtName: existData?.cityName ?? '',
              subDistrictId: existData?.subdistrictId ?? '0',
              subDistrictName: existData?.subdistrictName ?? '',
              villageId: existData?.villageId ?? '0',
              villageName: existData?.villageName ?? '',
              latitude: existData?.latitude ?? '0',
              longitude: existData?.longitude ?? '0',
              isPrimary: existData?.isPrimaryBool ?? false,
            )),
      child: BlocListener<DetailMemberAddressCubit, DetailMemberAddressState>(
        listener: (context, state) {
          if (state.status.isError) {
            if (state.errorMessage == 'TOKEN_EXPIRED') {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            } else {
              AppTopSnackBar(context).showDanger(state.errorMessage);
            }
          }

          if (state.status.isShowDialogLoading) {
            AppDialog().showLoadingDialog(context, dialog);
          }

          if (state.status.isHideDialogLoading) {
            dialog.hide();
          }

          if (state.status.isSuccessSubmit) {
            AppTopSnackBar(context).showSuccess('Berhasil menyimpan alamat');
            Navigator.of(context).pop(true);
          }
        },
        child: Scaffold(
          appBar: appDefaultAppBar(
            context,
            existData != null ? 'Ubah Alamat' : 'Tambah Alamat',
          ),
          body: DetailMemberAddressView(existData: existData),
        ),
      ),
    );
  }
}
