import 'package:sembast/sembast.dart';
import 'package:stickermaker/data/db.dart';
import 'package:stickermaker/data/sticker.dart';

class StickerDao {
  static const STICKER_STORE_NAME = 'stickers';

  final stickerStore = stringMapStoreFactory.store(STICKER_STORE_NAME);

  Future<Database> get _db async => await DB.instance.database;

  Future insert(Sticker sticker) async {
    print('Called insert!');
    await stickerStore.add(await _db, sticker.toMap());
  }

  Future update(Sticker sticker) async {
    final finder = Finder(filter: Filter.byKey(sticker.identifier));
    await stickerStore.update(await _db, sticker.toMap(), finder: finder);
  }

  Future<List<Sticker>> getAllSorted() async {
    final finder = Finder(sortOrders: [SortOrder('createTimeStamp')]);

    final recordSnapshot = await stickerStore.find(await _db, finder: finder);

    return recordSnapshot.map((e) {
      final sticker = Sticker.fromMap(e.value);
      sticker.identifier = e.key;
      return sticker;
    }).toList();
  }

  Future delete(Sticker sticker) async {
    final finder = Finder(filter: Filter.byKey(sticker.identifier));
    await stickerStore.delete(await _db, finder: finder);
  }
}
