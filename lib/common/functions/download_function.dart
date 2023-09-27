import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> saveFileToDirectory(String path, String subDirectory, String extension) async {
  Directory? directory;
  String newDir = '';
  String name = DateFormat('ddMMyyyyhhmmss').format(DateTime.now());

  try {
    if (Platform.isAndroid) {
      if (await checkStoragePermission()) {
        directory = await getExternalStorageDirectory();
        if (directory != null) {
          List<String> folders = directory.path.split('/');
          for (int i = 0; i < folders.length; i++) {
            String folder = folders[i];
            if (folder != 'Android') {
              newDir += folder + '/';
            } else {
              break;
            }
          }

          newDir += subDirectory;
          directory = Directory(newDir);

          File sourceFile = File(path);
          File destinationFile = File('${directory.path}/$name.$extension');

          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }

          if (await directory.exists()) {
            List<int> content = await sourceFile.readAsBytes();
            await destinationFile.writeAsBytes(content);
            return destinationFile.path; // Success
          } else {
            print('Directory does not exist: ${directory.path}');
          }

        } else {
          print('External storage directory is null.');
        }
      } else {
        print('Storage permission not granted.');
      }
    }
    else {
      if (await checkStoragePermission()) {
        directory = await getTemporaryDirectory();
        // Rest of your code for non-Android platforms
      }
    }
  } catch (e) {
    print('Error saving file: $e');
  }

  return 'Something went wrong';
}

Future<bool> checkStoragePermission() async {
  if (Platform.isAndroid) {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
    if ((info.version.sdkInt) <= 32) {
      if (await Permission.photos.request().isGranted) {
        return true;
      }
      if (await Permission.photos.request().isDenied) {
        await Permission.photos.request();
      }
      if (await Permission.photos.request().isPermanentlyDenied) {
        // openSettingsForPermissionDialog(context);
      }
      var status = await Permission.storage.status;
      if (status.isGranted) {
        return true;
      }
      if (status.isDenied) {
        await Permission.storage.request();
        // var permissionStatus = await Permission.storage.request();
        // if (permissionStatus == PermissionStatus.permanentlyDenied) {
        //   openAppSettings();
        // }
      }
      if (status.isPermanentlyDenied) {
        // openAppSettings();
      }
    }
    else {
      if (await Permission.manageExternalStorage.request().isGranted) {
        return true;
      }
      if (await Permission.manageExternalStorage.request().isDenied) {
        await Permission.manageExternalStorage.request();
      }
      if (await Permission.manageExternalStorage.request().isPermanentlyDenied) {
        // openSettingsForPermissionDialog(context);
      }
    }
  } else {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      return true;
    }
    if (status.isDenied) {
      await Permission.storage.request();
      // var permissionStatus = await Permission.storage.request();
      // if (permissionStatus == PermissionStatus.permanentlyDenied) {
      //   openAppSettings();
      // }
    }
    if (status.isPermanentlyDenied) {
      // openAppSettings();
    }
  }
  return false;
}