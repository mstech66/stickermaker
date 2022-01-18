import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stickermaker/data/sticker.dart';
import 'package:stickermaker/pages/add_sticker.dart';
import 'package:stickermaker/styles/styles.dart';

final Color cardColor = Color.fromRGBO(237, 237, 237, 1);
final Color cardPlaceholderColor = Color.fromRGBO(196, 196, 196, 1);

class StickerTile extends StatefulWidget {
  final Sticker sticker;

  const StickerTile({@required this.sticker});

  @override
  State<StickerTile> createState() => _StickerTileState();
}

class _StickerTileState extends State<StickerTile> {
  int stickerLength = 0;

  @override
  void initState() {
    stickerLength = widget.sticker.stickers.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: cardColor,
      shape: Styles.roundedBorderShape(),
      margin: EdgeInsets.all(8),
      child: InkWell(
        splashColor: cardPlaceholderColor,
        onTap: () {
          navigateToAddStickerPage(context, widget.sticker);
        },
        borderRadius: BorderRadius.circular(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RichText(
                  text: TextSpan(
                      text: widget.sticker.name,
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'ProductSans')),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                if (stickerLength >= 3)
                  ...widget.sticker.stickers
                      .map((sticker) => fileImage(sticker.imgFile))
                      .toList()
                      .take(3)
                else ...[
                  ...widget.sticker.stickers
                      .map((sticker) => fileImage(sticker.imgFile))
                      .toList(),
                  ...returnPlaceholderList(3 - stickerLength)
                ],
                addToWhatsappButton()
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget fileImage(filePath) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
    child: Stack(children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: cardPlaceholderColor),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.file(
          File(filePath),
          width: 50,
          height: 50,
        ),
      ),
    ]),
  );
}

List<Widget> returnPlaceholderList(int total) {
  List<Widget> placeholderList = [];
  for (var i = 0; i < total; i++) {
    placeholderList.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        child: Container(
          width: 50,
          height: 50,
        ),
        color: cardPlaceholderColor,
      ),
    ));
  }
  return placeholderList;
}

Widget addToWhatsappButton() {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Stack(
      children: [
        Card(
          elevation: 0,
          child: Container(
            width: 50,
            height: 50,
          ),
          color: cardPlaceholderColor,
        ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/whatsapp.png',
            width: 30,
            height: 30,
          ),
        ))
      ],
    ),
  );
}

navigateToAddStickerPage(context, sticker) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddSticker(
                sticker: sticker,
              )));
}
