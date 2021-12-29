import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StickerList extends StatefulWidget {
  const StickerList({Key key}) : super(key: key);

  @override
  _StickerListState createState() => _StickerListState();
}

class _StickerListState extends State<StickerList>
    with TickerProviderStateMixin {
  final primaryColor = Colors.green[400];
  final accentColor = Colors.green[500];
  AnimationController _animationController;
  bool _isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            title: Text(
              'Sticker Maker',
              style: Theme.of(context).textTheme.headline1,
            ),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)))),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          backgroundColor: accentColor,
          onPressed: () {
            animateFab();
            Navigator.pushNamed(context, '/addSticker');
            // _messengerKey.currentState
            //     .showSnackBar(SnackBar(content: Text('Coming Soon...')));
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
          ),
        ),
        body: Center(
          child: Text('Your stickers will show here'),
        ));
  }

  animateFab() {
    setState(() {
      _isPlaying = !_isPlaying;
      _isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }
}
