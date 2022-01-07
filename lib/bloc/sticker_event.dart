part of 'sticker_bloc.dart';

@immutable
abstract class StickerEvent extends Equatable {
  StickerEvent();
}

class LoadStickers extends StickerEvent{
  @override
  List<Object> get props => props;
}

class AddStickerEvent extends StickerEvent {
  final Sticker sticker;

  AddStickerEvent(this.sticker);

  @override
  List<Sticker> get props => [sticker];
}

class UpdateStickerEvent extends StickerEvent {
  final Sticker updatedSticker;

  UpdateStickerEvent(this.updatedSticker);

  @override
  List<Object> get props => [updatedSticker];
}

class DeleteStickerEvent extends StickerEvent {
  final Sticker deletedSticker;

  DeleteStickerEvent(this.deletedSticker);

  @override
  List<Object> get props => [deletedSticker];
}
