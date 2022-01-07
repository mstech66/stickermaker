import 'package:flutter/widgets.dart';

class Emoji {
  List<String> emojis;

  Emoji({@required this.emojis});

  Map<String, dynamic> toMap() {
    return {'emojis': emojis};
  }

  static Emoji fromMap(Map<String, dynamic> emojiMap) {
    return Emoji(emojis: emojiMap['emojis']);
  }

  @override
  String toString() {
    return 'emojis: $emojis';
  }
}
