import 'package:flutter/cupertino.dart';
import 'package:stickermaker/data/WhatsappSticker.dart';

class Sticker {
  String identifier;
  String name;
  String publisher;
  String trayImageFileName;
  String publisherWebsite = '';
  String privacyPolicyWebsite = '';
  String licenseAgreementWebsite = '';
  int createTimeStamp;
  List<WhatsappSticker> stickers = [];

  Sticker(
      {@required this.identifier,
      @required this.name,
      @required this.publisher,
      @required this.trayImageFileName,
      @required this.stickers,
      this.publisherWebsite,
      this.licenseAgreementWebsite,
      this.privacyPolicyWebsite,
      @required this.createTimeStamp});

  Map<String, dynamic> toMap() {
    final Map<String, Object> data = Map<String, Object>();
    if (this.stickers != null) {
      data['stickers'] =
          this.stickers.map((sticker) => sticker.toMap()).toList();
    }

    return {
      'identifier': identifier,
      'name': name,
      'publisher': publisher,
      'trayImageFileName': trayImageFileName,
      'publisherWebsite': publisherWebsite,
      'licenseAgreementWebsite': licenseAgreementWebsite,
      'privacyPolicyWebsite': privacyPolicyWebsite,
      'stickers': data['stickers'],
      'createTimeStmap': createTimeStamp
    };
  }

  static Sticker fromMap(Map<String, dynamic> sticker) {
    print('fromMap sticker data type is ${sticker["stickers"].runtimeType}');
    return Sticker(
        identifier: sticker['identifier'],
        name: sticker['name'],
        publisher: sticker['publisher'],
        trayImageFileName: sticker['trayImageFileName'],
        publisherWebsite: sticker['publisherWebsite'],
        licenseAgreementWebsite: sticker['licenseAgreementWebsite'],
        privacyPolicyWebsite: sticker['privacyPolicyWebsite'],
        stickers: sticker['stickers'] != null
            ? (sticker['stickers'] as List)
                .map((sticker) => WhatsappSticker.fromMap(sticker))
                .toList()
            : null,
        createTimeStamp: sticker['createTimeStamp']);
  }

  @override
  String toString() {
    return 'Name: ${this.name} Publisher: ${this.publisher} Stickers: ${this.stickers}';
  }
}
