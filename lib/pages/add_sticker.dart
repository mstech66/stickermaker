import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stickermaker/pages/sticker_list.dart';
import 'package:whatsapp_stickers/exceptions.dart';
import 'package:whatsapp_stickers/whatsapp_stickers.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddSticker extends StatefulWidget {
  @override
  State<AddSticker> createState() => _AddStickerState();
}

class _AddStickerState extends State<AddSticker> with TickerProviderStateMixin {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final primaryColor = Colors.green[400];
  final accentColor = Colors.green[500];
  AnimationController _animationController;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
            decoration: InputDecoration(border: InputBorder.none, hintText: 'Sticker Title',),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: () {
          animateFab();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => StickerList()));
          // _messengerKey.currentState
          //     .showSnackBar(SnackBar(content: Text('Coming Soon...')));
        },
        child: Icon(Icons.save_rounded, color: Colors.black54,),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Center(
              child: ElevatedButton(
                child: Text('Pick Image files'),
                onPressed: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles(allowMultiple: true);
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
    );
  }

  animateFab() {
    setState(() {
      _isPlaying = !_isPlaying;
      _isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
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
