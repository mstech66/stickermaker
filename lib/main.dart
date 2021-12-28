import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_stickers/exceptions.dart';
import 'package:whatsapp_stickers/whatsapp_stickers.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatefulWidget {
  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sticker Maker'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Sticker Title',
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: 'Manthan',
                    decoration: InputDecoration(
                        labelText: 'Sticker Author Name',
                        border: OutlineInputBorder()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: ElevatedButton(
                  child: Text('Pick Image files'),
                  onPressed: () async {
                    FilePickerResult result = await FilePicker.platform
                        .pickFiles(allowMultiple: true);
                    if (result != null) {
                      List<File> fileList =
                          result.paths.map((e) => File(e)).toList();
                      installFromFileList(fileList, context);
                    } else {
                      print('No Files Chosen!');
                    }
                  },
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
          ),
        ),
      ),
    );
  }

  Future installFromFileList(List<File> fileList, context) async {
    var stickerPack = WhatsappStickers(
      identifier: 'TestDemo6667',
      name: 'Cuppy Flutter WhatsApp Stickers',
      publisher: 'John Doe',
      trayImageFileName:
          WhatsappStickerImage.fromAsset('assets/tray_Cuppy.png'),
      publisherWebsite: '',
      privacyPolicyWebsite: '',
      licenseAgreementWebsite: '',
    );

    addImagesToWhatsapp(fileList, stickerPack).then((_) async {
      try {
        await stickerPack.sendToWhatsApp();
      } on WhatsappStickersException catch (e) {
        print(e.cause);
        _messengerKey.currentState
            .showSnackBar(SnackBar(content: Text(e.cause)));
      }
    });
  }

  convertFileToWebp(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile = file.path.split('/').last.split('.').first;
    Uint8List imageData = await file.readAsBytes();
    imageData = Uint8List.fromList(imageData);
    print('imgData is $imageData');
    final result = await FlutterImageCompress.compressWithList(imageData,
        minHeight: 512,
        minWidth: 512,
        quality: 90,
        format: CompressFormat.webp);
    print('result is $result');
    final tempPath = await File('${directory.path}/$imageFile.webp').create();
    print('tempPath is $tempPath');
    File resultFile = await tempPath.writeAsBytes(result);
    return resultFile;
  }

  Future<File> resizeAndCropImage(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageFile = file.path.split('/').last.split('.').first;
    var image = decodeImage(file.readAsBytesSync());
    var resized = copyResizeCropSquare(image, 512);
    Future<File> resizedFile = File('${directory.path}/$imageFile.png')
        .writeAsBytes(encodePng(resized));
    return resizedFile;
  }

  Future addImagesToWhatsapp(fileList, stickerPack) {
    return Future.forEach(fileList, (file) async {
      await resizeAndCropImage(file).then((resizedFile) async {
        File imgFile = await convertFileToWebp(resizedFile);
        WhatsappStickerImage stickerImage =
            WhatsappStickerImage.fromFile(imgFile.path);
        const emojis = ['🙂', '😛'];
        stickerPack.addSticker(stickerImage, emojis);
      });
    });
  }
}
