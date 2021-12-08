import 'dart:io';

import 'package:whatsapp_stickers/exceptions.dart';
import 'package:whatsapp_stickers/whatsapp_stickers.dart';

class Whatsapp{
  static Future installFromFiles(List<File> fileList) async {
    var stickerPack = WhatsappStickers(
      identifier: 'cuppyFlutterWhatsAppStickers',
      name: 'Cuppy Flutter WhatsApp Stickers',
      publisher: 'Manthan Mevada',
      trayImageFileName: WhatsappStickerImage.fromAsset('assets/images/tray_Cuppy.png'),
      publisherWebsite: '',
      privacyPolicyWebsite: '',
      licenseAgreementWebsite: '',
    );

    for (var file in fileList) {
      print('File Path is: '+ file.path);
      stickerPack.addSticker(WhatsappStickerImage.fromFile(file.path), ['😋', '❤']);
    }

    try {
      await stickerPack.sendToWhatsApp();
    } on WhatsappStickersException catch (e) {
      print(e.cause);
    }
  }
}