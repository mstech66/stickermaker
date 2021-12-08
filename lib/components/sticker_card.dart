import 'package:flutter/material.dart';

class StickerCard extends StatelessWidget {
  const StickerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 1.0,
        child: Row(
          children: [
            const Text('Sample Title'),
            const Spacer(),
            Image.asset(
              'assets/images/img1.jpg',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
