import 'package:flutter/cupertino.dart';

class WhatsappSticker {
  String imgFile;
  List<String> emojis;

  WhatsappSticker({@required this.imgFile, @required this.emojis});

  Map<String, Object> toMap() {
    return {'image_file': imgFile, 'emojis': emojis};
  }

  static WhatsappSticker fromMap(Map<String, Object> sticker) {
    return WhatsappSticker(
        imgFile: sticker['image_file'],
        emojis: new List<String>.from(sticker['emojis']));
  }

  @override
  String toString() {
    return 'image_file: ${this.imgFile}, emojis: ${this.emojis}';
  }
}
