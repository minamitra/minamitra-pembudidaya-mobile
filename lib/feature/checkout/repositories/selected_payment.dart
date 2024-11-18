import 'package:equatable/equatable.dart';

class SelectedPayment extends Equatable {
  final String? id;
  final String? imageUrl;
  final String? imageAsset;
  final String? name;
  final String? accountName;
  final String? accountNumber;
  final bool? activeBool;
  final DateTime? createDatetime;
  final String? updateDatetime;
  final String? currentBalance;
  final String? paymentMethod;
  final String? description;

  const SelectedPayment({
    this.id,
    this.imageUrl,
    this.imageAsset,
    this.name,
    this.accountName,
    this.accountNumber,
    this.activeBool,
    this.createDatetime,
    this.updateDatetime,
    this.currentBalance,
    this.paymentMethod,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        imageAsset,
        name,
        accountName,
        accountNumber,
        activeBool,
        createDatetime,
        updateDatetime,
        currentBalance,
        paymentMethod,
        description,
      ];
}
