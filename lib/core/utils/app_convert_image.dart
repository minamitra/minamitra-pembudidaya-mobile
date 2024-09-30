import 'dart:io';
import 'dart:typed_data';

File convertUint8ListToFile(Uint8List uint8List) {
  final tempDir = Directory.systemTemp;
  final tempFile = File('${tempDir.path}/temp.png');
  tempFile.writeAsBytesSync(uint8List);
  return tempFile;
}
