import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'qrscan_state.dart';

class QrscanCubit extends Cubit<QrscanState> {
  QrscanCubit() : super(const QrscanState());

  void setQRScanType(QRScanType qrScanType) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(qrScanType: qrScanType, status: GlobalState.loaded));
  }
}
