// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

bool checkAndroidVersion() {
  debugPrint("Android version: ${Platform.operatingSystemVersion}");
  String osVersion = Platform.operatingSystemVersion;

  // Extract the API level from the string (e.g., "AP31.240617.003" -> 31)
  RegExp regExp = RegExp(r'AP(\d+)');
  Match? match = regExp.firstMatch(osVersion);

  if (match != null) {
    int apiLevel = int.parse(match.group(1)!);

    // Check if API level is 30 or above (Android 11 and above)
    if (apiLevel >= 30) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}

Future<bool> takeScreenshot(BuildContext context) async {
  PermissionStatus resultPermission;
  resultPermission = await Permission.storage.request();
  if (Platform.isAndroid) {
    if (checkAndroidVersion()) {
      resultPermission = await Permission.manageExternalStorage.request();
    } else {
      resultPermission = await Permission.storage.request();
    }
  }

  if (resultPermission == PermissionStatus.granted) {
    String? path = await FlutterNativeScreenshot.takeScreenshot();
    debugPrint('Screenshot taken, path: $path');
    if (path == null || path.isEmpty) {
      // if error
      debugPrint("Error in Path");
      return false;
    }
    String destinationFile =
        '${(await getTemporaryDirectory()).path}/screenshot.png';

    File sourceFile = File(path);
    try {
      // preferred way to move the file
      await sourceFile.rename(destinationFile);
    } catch (e) {
      // if rename fails, copy the source file and then delete it
      await sourceFile.copy(destinationFile);
      await sourceFile.delete();
    }

    await Share.shareXFiles([XFile(destinationFile)]);
    return true;
  } else {
    return false;
  }
}
