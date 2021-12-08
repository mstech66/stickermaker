import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:stickermaker/components/sticker_card.dart';
import 'package:stickermaker/service/whatsapp.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: StickerCard(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),
            const Spacer(),
            IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.info))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
            if(result != null){
              List<File> files = result.paths.map((e) => File(e!)).toList();
              Whatsapp.installFromFiles(files);
            }
            else{
              print('No Files Chosen!');
            }
          },
          child: const Icon(Icons.add)),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
