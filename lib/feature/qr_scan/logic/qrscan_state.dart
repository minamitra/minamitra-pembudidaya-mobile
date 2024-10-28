part of 'qrscan_cubit.dart';

enum QRScanType { scan, generate }

class QrscanState extends Equatable {
  const QrscanState({
    this.status = GlobalState.initial,
    this.errorMessage = "",
    this.qrScanType = QRScanType.scan,
  });

  final GlobalState status;
  final String errorMessage;
  final QRScanType qrScanType;

  QrscanState copyWith({
    GlobalState? status,
    String? errorMessage,
    QRScanType? qrScanType,
  }) {
    return QrscanState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      qrScanType: qrScanType ?? this.qrScanType,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        qrScanType,
      ];
}
