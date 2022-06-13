import 'package:flutter/material.dart';
import 'package:stickermaker/styles/styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sticker Maker',
                    style: Styles.headerTextStyle,
                  ),
                  Text(
                    'Simple Easy and Ad-Free Experience to create and add stickers for WhatsApp',
                    style: Styles.paragraphTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'And, this link will not work cause I did not deploy to Play Store YET :D',
                    style: Styles.paragraphTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  new Image.asset(
                    'assets/images/google-play-badge.png',
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
          FittedBox(
            child: new Image.asset(
              'assets/images/deviceart.png',
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
