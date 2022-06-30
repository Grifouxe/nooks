import 'package:permission_handler/permission_handler.dart';

void requestPermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }

  var status1 = await Permission.manageExternalStorage.status;
  if (!status1.isGranted) {
    await Permission.manageExternalStorage.request();
  }
}