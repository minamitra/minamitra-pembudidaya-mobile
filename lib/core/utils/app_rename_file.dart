import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File> renameFile(File file) async {
  log("masuk");
  String savePath = '';
  bool isGranted = await Permission.storage.request().isGranted;
  await Permission.manageExternalStorage.request();

  log('isGranted: $isGranted');
  if (!isGranted) {
    await Permission.storage.request();
  }
  if (Platform.isIOS) {
    final directory = await getApplicationDocumentsDirectory();
    savePath = '${directory.path}/';
  } else if (Platform.isAndroid) {
    final directoryFirst = Directory('/storage/emulated/0/Download');
    final directory = directoryFirst.path;
    savePath = '$directory/';
  }
  log('aman 1');
  String fileExt = file.path.split('.').last;
  log('aman 2');
  // String dir = path.dirname(tmpFile.path);
  String newPath = path.join(
    savePath,
    'mobile-mina-mitra-mandiri-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}.$fileExt',
  );
  log('aman 3');
  File newFile = await File(newPath).writeAsBytes(file.readAsBytesSync());
  return newFile;
}

XFile renameXFile(XFile file) {
  File tmpFile = File(file.path);
  String fileExt = tmpFile.path.split('.').last;
  String dir = path.dirname(tmpFile.path);
  String newPath = path.join(
    dir,
    'mobile-mina-mitra-mandiri-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}.$fileExt',
  );
  tmpFile.renameSync(newPath);
  return XFile(tmpFile.path);
}
