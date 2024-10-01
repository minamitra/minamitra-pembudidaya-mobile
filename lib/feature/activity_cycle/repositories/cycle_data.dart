import 'dart:ui';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

enum CycleType {
  active,
  done,
  ready,
  failed,
  onBid,
}

String cycleTypeToString(CycleType type) {
  switch (type) {
    case CycleType.active:
      return 'Berjalan';
    case CycleType.onBid:
      return 'Berjalan';
    case CycleType.done:
      return 'Panen Berhasil';
    case CycleType.ready:
      return 'Siap Panen';
    case CycleType.failed:
      return 'Gagal';
  }
}

CycleType convertToCycleType(String status) {
  switch (status.toLowerCase()) {
    case "active":
      return CycleType.active;
    case "harvest":
      return CycleType.ready;
    case "onbid":
      return CycleType.onBid;
    default:
      return CycleType.done;
  }
}

Color cycleTypeColor(CycleType type) {
  switch (type) {
    case CycleType.active:
      return AppColor.secondary[900]!;
    case CycleType.onBid:
      return AppColor.secondary[900]!;
    case CycleType.done:
      return AppColor.green[500]!;
    case CycleType.ready:
      return AppColor.accent[900]!;
    case CycleType.failed:
      return AppColor.red[500]!;
  }
}

class Cycle {
  final String title;
  final String date;
  final CycleType type;
  final String amount;
  final String price;
  final String weight;
  final String target;

  Cycle({
    required this.title,
    required this.date,
    required this.type,
    required this.amount,
    required this.price,
    required this.weight,
    required this.target,
  });
}

final List<Cycle> listCycleAll = [
  Cycle(
    title: 'Siklus 1',
    date: '05-08-2024 17:00 WIB',
    type: CycleType.ready,
    amount: '1000',
    price: 'Rp 1.000.000',
    weight: '250',
    target: '200',
  ),
  Cycle(
    title: 'Siklus 2',
    date: '25-07-2024 17:00 WIB',
    type: CycleType.done,
    amount: '800',
    price: 'Rp 800.000',
    weight: '200',
    target: '150',
  ),
  Cycle(
    title: 'Siklus 3',
    date: '15-06-2024 17:00 WIB',
    type: CycleType.done,
    amount: '750',
    price: 'Rp 750.000',
    weight: '175',
    target: '120',
  ),
  Cycle(
    title: 'Siklus 4',
    date: '27-05-2024 17:00 WIB',
    type: CycleType.done,
    amount: '1200',
    price: 'Rp 1.200.000',
    weight: '280',
    target: '220',
  ),
  Cycle(
    title: 'Siklus 5',
    date: '05-08-2024 17:00 WIB',
    type: CycleType.onBid,
    amount: '1000',
    price: 'Rp 1.000.000',
    weight: '250',
    target: '200',
  ),
];

final List<Cycle> listCycleActive =
    listCycleAll.where((element) => element.type == CycleType.ready).toList();

final List<Cycle> listCycleOnBid =
    listCycleAll.where((element) => element.type == CycleType.onBid).toList();

final List<Cycle> listCycleDone =
    listCycleAll.where((element) => element.type == CycleType.done).toList();
