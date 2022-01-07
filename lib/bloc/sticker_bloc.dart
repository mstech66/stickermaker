import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stickermaker/data/sticker.dart';
import 'package:stickermaker/data/sticker_dao.dart';

part 'sticker_event.dart';
part 'sticker_state.dart';

class StickerBloc extends Bloc<StickerEvent, StickerState> {
  StickerDao stickerDao = StickerDao();

  StickerBloc() : super(StickerLoading()) {
    on<LoadStickers>(_reloadStickers);

    on<AddStickerEvent>(_addStickers);

    on<UpdateStickerEvent>(_updateStickers);
  }

  void _reloadStickers(LoadStickers event, Emitter<StickerState> emit) async {
    emit(StickerLoading());
    List<Sticker> stickerList = await stickerDao.getAllSorted();
    emit(StickerLoaded(stickerList));
  }

  void _addStickers(AddStickerEvent event, Emitter<StickerState> emit) async {
    emit(StickerLoading());
    await stickerDao.insert(event.sticker);
    List<Sticker> stickerList = await stickerDao.getAllSorted();
    emit(StickerLoaded(stickerList));
  }

  void _updateStickers(
      UpdateStickerEvent event, Emitter<StickerState> emit) async {
    emit(StickerLoading());
    await stickerDao.update(event.updatedSticker);
    List<Sticker> stickerList = await stickerDao.getAllSorted();
    emit(StickerLoaded(stickerList));
  }
}
