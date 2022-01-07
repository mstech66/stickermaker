import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  static final DB _singleton = DB._();
  static DB get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  DB._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return await _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Directory dbDirectory = await new Directory(appDocumentDir.path + '/' + 'dir').create(recursive: true);
    final dbPath = '${dbDirectory.path}/stickers.db';
    print('dbPath is $dbPath');
    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter.complete(database);
  }
}
