import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickDocumentImage(
  BuildContext context,
  ImageSource source,
) async {
  final ImagePicker picker = ImagePicker();
  final pickedImage = await picker.pickImage(
    source: source,
    imageQuality: 50,
  );
  if (pickedImage == null) {
    return null;
  }
  return pickedImage;
}
