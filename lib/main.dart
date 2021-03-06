import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickermaker/pages/add_sticker.dart';
import 'package:stickermaker/pages/sticker_list.dart';
import 'package:stickermaker/pages/web/homepage.dart';
import 'package:stickermaker/styles/styles.dart';

import 'bloc/sticker_bloc.dart';

void main() {
  runApp(AppRoot());
}

class AppRoot extends StatefulWidget {
  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  final primaryColor = Colors.green[400];
  final accentColor = Colors.black54;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        return Container();
      } else {
        return BlocProvider(
          create: (context) => StickerBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: _messengerKey,
            theme: ThemeData(
                fontFamily: 'ProductSans',
                primaryColor: primaryColor,
                accentColor: accentColor,
                textTheme: TextTheme(
                    headline1: TextStyle(
                      fontSize: 24.0,
                      color: accentColor,
                    ),
                    headline2: TextStyle(fontSize: 36.0, color: accentColor))),
            home: StickerList(),
            routes: <String, WidgetBuilder>{
              '/addSticker': (BuildContext context) => new AddSticker(),
            },
          ),
        );
      }
    } catch (e) {
      return MaterialApp(
        home: HomePage(),
        theme: Styles.themeData,
      );
    }
  }
}
