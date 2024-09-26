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
    description: 'Sisa Saldo: Rp 2.5000.000',
  ),
  MethodPaymentData(
    icon: AppAssets.cashIcon,
    name: 'Tunai',
    description: 'Bayar Menggunakan Uang Tunai',
  ),
];

List<MethodPaymentData> listMethodBank = [
  MethodPaymentData(
    icon: AppAssets.bcaBankIcon,
    name: 'BCA',
    description: 'Transfer ke Rekening BCA',
  ),
  MethodPaymentData(
    icon: AppAssets.mandiriBankIcon,
    name: 'Mandiri',
    description: 'Transfer ke Rekening Mandiri',
  ),
  MethodPaymentData(
    icon: AppAssets.briBankIcon,
    name: 'BRI',
    description: 'Transfer ke Rekening BRI',
  ),
];
