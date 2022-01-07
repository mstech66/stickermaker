import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stickermaker/bloc/sticker_bloc.dart';

class StickerList extends StatefulWidget {
  const StickerList({Key key}) : super(key: key);

  @override
  _StickerListState createState() => _StickerListState();
}

class _StickerListState extends State<StickerList> {
  final primaryColor = Colors.green[400];
  final accentColor = Colors.green[500];
  StickerBloc stickerBloc;

  @override
  void initState() {
    super.initState();
    stickerBloc = BlocProvider.of<StickerBloc>(context);

    stickerBloc.add(LoadStickers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StickerBloc, StickerState>(
      bloc: stickerBloc,
      builder: (BuildContext context, StickerState state) {
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
                Navigator.pushNamed(context, '/addSticker');
                // _messengerKey.currentState
                //     .showSnackBar(SnackBar(content: Text('Coming Soon...')));
              },
              child: Icon(
                Icons.add_rounded,
                color: Theme.of(context).accentColor,
              ),
            ),
            body: state is StickerLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state.props.length == 0
                    ? Center(
                        child: Text("No stickers added 😛"),
                      )
                    : ListView.builder(
                        itemCount: state.props.length,
                        itemBuilder: (context, index) {
                          var displayedSticker = state.props[index];
                          print(displayedSticker);
                          return ListTile(
                            title: Text(displayedSticker.name),
                          );
                        },
                      ));
      },
    );
  }
}
