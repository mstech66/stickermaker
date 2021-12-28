import 'package:flutter/cupertino.dart';

class Sticker {
  String _name;
  String _publisher;
  Map<String, List<String>> _stickers = Map<String, List<String>>();

  Sticker(String name, String publisher, Map<String, List<String>> stickers) {
    this._name = name;
    this._publisher = publisher;
    this._stickers = stickers;
  }

  printStickerInfo(){
    print('Name: ${this._name} Publisher: ${this._publisher} Stickers: ${this._stickers}');
  }

}