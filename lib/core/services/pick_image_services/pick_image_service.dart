import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_top_snackbar.dart';
import 'package:system_info2/system_info2.dart';

Future<XFile?> pickDocumentImage(
  BuildContext context,
  ImageSource source, {
  List<String> typeValidations = const [],
  int maxSize = 4000000,
}) async {
  var phyMemory = SysInfo.getFreePhysicalMemory() ~/ 1000000;
  var virMemory = SysInfo.getFreeVirtualMemory() ~/ 1000000;
  if (phyMemory < 25) {
    AppTopSnackBar(context).showInfo(
      'Anda kekurangan memori fisik, silahkan clear cache',
    );
    return null;
  }
  if (virMemory < 250) {
    AppTopSnackBar(context).showInfo(
      'Anda kekurangan memori virtual, silahkan clear cache',
    );
    return null;
  }
  final ImagePicker picker = ImagePicker();
  final pickedImage = await picker.pickImage(
    source: source,
    imageQuality: 70,
  );
  if (pickedImage == null) {
    return null;
  }

  final size = await pickedImage.length();
  if (size > maxSize) {
    if (context.mounted) {
      AppTopSnackBar(context).showInfo(
        'Ukuran gambar melebihi batas maksimal ${maxSize / 1000000}MB',
      );
    }
    return null;
  }

  if (typeValidations.isNotEmpty) {
    final type = pickedImage.path.split('.').last;
    if (!typeValidations.contains(type)) {
      if (context.mounted) {
        AppTopSnackBar(context).showInfo(
          'Tipe file tidak valid',
        );
      }
      return null;
    }
  }

  return pickedImage;
}
