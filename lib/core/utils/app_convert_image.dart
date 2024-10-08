import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

File convertUint8ListToFile(Uint8List uint8List) {
  final tempDir = Directory.systemTemp;
  final tempFile = File('${tempDir.path}/temp.png');
  tempFile.writeAsBytesSync(uint8List);
  return tempFile;
}

Future<File> appConvertImage(Uint8List image) async {
  Uint8List imageInUnit8List = image;
  final tempDir = await getTemporaryDirectory();
  File file = await File('${tempDir.path}/image.png').create();
  file.writeAsBytesSync(imageInUnit8List);
  return file;
}
