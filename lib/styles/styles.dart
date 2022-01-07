import 'package:flutter/material.dart';

class Styles {
  static const CARD_BORDER_RADIUS = 12.0;

  static RoundedRectangleBorder roundedBorderShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CARD_BORDER_RADIUS));
  }

  
}
