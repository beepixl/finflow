// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

import 'package:screenshot/screenshot.dart';
import 'package:download/download.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_downloader_web/image_downloader_web.dart';

class CustomScreenshotCopy extends StatefulWidget {
  const CustomScreenshotCopy({
    Key? key,
    this.width,
    this.height,
    // this.data,
  }) : super(key: key);

  final double? width;
  final double? height;
  // final String? data;

  @override
  _CustomScreenshotCopyState createState() => _CustomScreenshotCopyState();
}

class _CustomScreenshotCopyState extends State<CustomScreenshotCopy> {
  // Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? _imageFile;
  // Function to generate a random Uint8List of a given length
  static Uint8List generateRandomUint8List(int length) {
    final random = Random();
    final List<int> bytes = List.generate(length, (_) => random.nextInt(256));
    return Uint8List.fromList(bytes);
  }

  Future<void> saveInBrowser(Uint8List bytes) async {
    final WebImageDownloader _webImageDownloader = WebImageDownloader();

    await _webImageDownloader.downloadImageFromUInt8List(uInt8List: bytes);
  }

  //  Image path based on the os type
  Future<void> captureAndDownloadFromWidget() async {
    var imagePath = '';
    if (Platform.isMacOS) {
      imagePath = (await getApplicationDocumentsDirectory()).path.trim();
    } else if (Platform.isAndroid) {
      imagePath = (await getExternalStorageDirectory())!.path.trim();
    } else if (Platform.isIOS) {
      imagePath = (await getApplicationDocumentsDirectory()).path.trim();
    }

    Random().nextInt(15000);
    var fileName = '${Random().nextInt(15000)}.png';
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    screenshotController.capture().then((image) {
      //Capture Done

      saveInBrowser(image!);
    }).catchError((onError) {
      print(onError);
    });
    // await screenshotController.captureAndSave(imagePath,
    //     fileName: fileName,
    //     pixelRatio: pixelRatio,
    //     delay: const Duration(milliseconds: 50));
    // File? file = await File('$imagePath/$fileName').create(recursive: true);
    // await ImageGallerySaver.saveFile('$imagePath/$fileName');

    // await Share.shareXFiles([XFile('$imagePath/$fileName')]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Screenshot(
          controller: screenshotController,
          child: Material(
            color: Colors.transparent,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4B39EF), Color(0xFF39D2C0)],
                  stops: [0, 1],
                  begin: AlignmentDirectional(1, -1),
                  end: AlignmentDirectional(-1, 1),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 24, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Balance',
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      '₹1,25,000',
                      style:
                          FlutterFlowTheme.of(context).displayMedium.override(
                                fontFamily: 'Sora',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.trending_up,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          size: 24,
                        ),
                        Text(
                          '+₹15,000 this month',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ].divide(SizedBox(width: 8)),
                    ),
                  ].divide(SizedBox(height: 16)),
                ),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: captureAndDownloadFromWidget,
          child: Text('Capture and Download'),
        ),
      ],
    );
  }
}
