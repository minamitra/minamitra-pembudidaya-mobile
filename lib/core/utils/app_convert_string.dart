import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';

String appConvertCurrency(double value) {
  String converted = NumberFormat('#,###', 'id_ID').format(value);
  return "Rp $converted";
}

extension HandlingEmptyString on String? {
  String handlingEmptyString() {
    return (this ?? "").isEmpty ? "-" : this ?? "-";
  }

  String handlingEmptyStringWithTNoteNotes() {
    return (this ?? "").isEmpty
        ? "Tidak Ada Catatan"
        : this ?? "Tidak Ada Catatan";
  }

  String? handleEmptyStringToNull() {
    return (this ?? "").isEmpty ? null : this;
  }

  String handleEmptyStringToZero() {
    return (this ?? "").isEmpty ? "0" : this ?? "0";
  }
}

extension FormatCurrency on String {
  String unFormatedCurrency() {
    return replaceAll("Rp ", "").replaceAll(".", "");
  }
}

extension PondStatusConverter on String {
  String convertPondStatus() {
    switch (toLowerCase()) {
      case "approved":
        return "Aktif";
      case "rejected":
        return "Ditolak";
      case "submission":
        return "Menunggu Persetujuan";
      default:
        return "-";
    }
  }

  Color convertPondStatusColor() {
    switch (toLowerCase()) {
      case "approved":
        return AppColor.green[500]!;
      case "rejected":
        return AppColor.red;
      case "submission":
        return AppColor.accent;
      default:
        return AppColor.green[500]!;
    }
  }

  bool isCanSeeDetail() {
    switch (toLowerCase()) {
      case "approved":
        return true;
      case "rejected":
        return false;
      case "submission":
        return false;
      default:
        return false;
    }
  }
}

extension ParameterCultivation on String {
  String parameter() {
    switch (this) {
      case "MBW (Mean Body Weight) (gram)":
        return "mbw";
      case "Total Biomass (kg)":
        return "biomas";
      case "Pakan Harian":
        return "pakan_harian";
      case "Pakan Kumulatif":
        return "pakan_kumulatif";
      case "SR (Survival Rate) (%)":
        return "sr";
      case "FCR (Feed Convertion Ratio)":
        return "fr";
      case "ADG (Average Daily Growth) (gram)":
        return "adg";
      default:
        return "mbw";
    }
  }

  String convertFilterToTitle() {
    switch (this) {
      case "mbw":
        return "MBW (gram)";
      case "biomas":
        return "Total Biomass (kg)";
      case "pakan_harian":
        return "Pakan Harian";
      case "pakan_kumulatif":
        return "Pakan Kumulatif";
      case "sr":
        return "SR (Survival Rate) (%)";
      case "fr":
        return "FCR (Feed Convertion Ratio)";
      case "adg":
        return "ADG (gram)";
      default:
        return "MBW (gram)";
    }
  }
}
