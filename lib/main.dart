import 'package:flutter/material.dart';
import 'package:stickermaker/pages/add_sticker.dart';
import 'package:stickermaker/pages/sticker_list.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatefulWidget {
  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> with TickerProviderStateMixin {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final primaryColor = Colors.green[400];
  final accentColor = Colors.black54;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _messengerKey,
      theme: ThemeData(
        fontFamily: 'ProductSans',
        primaryColor: primaryColor,
        accentColor: accentColor,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 28.0, color: accentColor, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 36.0, color: accentColor)
        )
      ),
      home: StickerList(),
      routes: <String, WidgetBuilder> {
        '/addSticker': (BuildContext context) => new AddSticker(),
      },
    );
  }
}
