import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imagePkg;
import 'package:path_provider/path_provider.dart';
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
  final whatsappAccentColor = Color.fromRGBO(37, 211, 102, 1);
  AnimationController _animationController;
  bool _isPlaying = true;
  TextEditingController _titleEditingController = TextEditingController();
  List<File> convertedImageFileList = [];
  WhatsappStickers stickerPack;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: TextField(
            autofocus: true,
            controller: _titleEditingController,
            cursorColor: Colors.black54,
            style:
                TextStyle(fontSize: 24, color: Theme.of(context).accentColor),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Sticker Title',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54))),
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
          Navigator.pop(context);
          // _messengerKey.currentState
          //     .showSnackBar(SnackBar(content: Text('Coming Soon...')));
        },
        child: Icon(
          Icons.save_rounded,
          color: Colors.black54,
        ),
      ),
      body: Stack(children: [
        Container(
            padding: EdgeInsets.only(top: 41),
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                addTile(),
                for (var file in convertedImageFileList)
                  Card(
                    child: Image.file(file, fit: BoxFit.fill),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  )
              ],
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 52),
              child: FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: accentColor,
                  onPressed: () async {
                    try {
                      await stickerPack.sendToWhatsApp();
                    } on WhatsappStickersException catch (e) {
                      print(e.cause);
                      showErrorSnackBar(e.cause);
                    }
                  },
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/whatsapp.png',
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'ADD TO WHATSAPP',
                        style: TextStyle(height: 1.2),
                      )
                    ],
                  )),
            ))
      ]),
    );
  }
  //Prev Used to animate button will remove if not needed...
  // animateFab() {
  //   setState(() {
  //     _isPlaying = !_isPlaying;
  //     _isPlaying
  //         ? _animationController.forward()
  //         : _animationController.reverse();
  //   });
  // }

  Future installFromFileList(List<File> fileList, context) async {
    if (stickerPack == null) {
      stickerPack = WhatsappStickers(
        identifier: generateRandomStickerId(_titleEditingController.value.text),
        name: _titleEditingController.value.text,
        publisher: 'Manthan',
        trayImageFileName:
            WhatsappStickerImage.fromAsset('assets/tray_Cuppy.png'),
        publisherWebsite: '',
        privacyPolicyWebsite: '',
        licenseAgreementWebsite: '',
      );
    }
    addImagesToWhatsapp(fileList, stickerPack);
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
    var image = imagePkg.decodeImage(file.readAsBytesSync());
    var resized = imagePkg.copyResizeCropSquare(image, 512);
    Future<File> resizedFile = File('${directory.path}/$imageFile.png')
        .writeAsBytes(imagePkg.encodePng(resized));
    return resizedFile;
  }

  Future addImagesToWhatsapp(fileList, stickerPack) {
    return Future.forEach(fileList, (file) async {
      await resizeAndCropImage(file).then((resizedFile) async {
        File imgFile = await convertFileToWebp(resizedFile);
        setState(() {
          convertedImageFileList.add(imgFile);
        });
        WhatsappStickerImage stickerImage =
            WhatsappStickerImage.fromFile(imgFile.path);
        const emojis = ['🙂', '😛'];
        stickerPack.addSticker(stickerImage, emojis);
      });
    });
  }

  String generateRandomStickerId(String name) {
    Random random = new Random();
    return '${name.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll(' ', '').substring(0, (name.length / 2).round())}${random.nextInt(100)}';
  }

  showErrorSnackBar(text) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text(
          text,
          style: TextStyle(color: Colors.white70),
        ),
        backgroundColor: Colors.red));
  }

  Widget addTile() {
    return Card(
      color: accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        customBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () async {
          if (_titleEditingController.value.text.isEmpty) {
            showErrorSnackBar('Please Enter Title for your sticker pack');
          } else {
            FilePickerResult result =
                await FilePicker.platform.pickFiles(allowMultiple: true);
            if (result != null) {
              List<File> fileList = result.paths.map((e) => File(e)).toList();
              installFromFileList(fileList, context);
            } else {
              print('No Files Chosen!');
            }
          }
        },
        child: Container(
          child: Center(
              child: Icon(
            Icons.add_rounded,
            size: 36,
          )),
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
