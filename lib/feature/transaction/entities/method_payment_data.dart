import 'package:minamitra_pembudidaya_mobile/core/utils/app_assets.dart';

class MethodPaymentData {
  final String icon;
  final String name;
  final String description;

  MethodPaymentData({
    required this.icon,
    required this.name,
    required this.description,
  });
}

List<MethodPaymentData> listMethodPayment = [
  MethodPaymentData(
    icon: AppAssets.walletIcon,
    name: 'Plafon',
    description: 'Konfirmasi Otomatis',
  ),
  MethodPaymentData(
    icon: AppAssets.cashIcon,
    name: 'Tunai',
    description: 'Bayar Menggunakan Uang Tunai',
  ),
];
