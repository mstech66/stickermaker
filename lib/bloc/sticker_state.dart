part of 'sticker_bloc.dart';

@immutable
abstract class StickerState extends Equatable {
  StickerState();

  @override
  List<Sticker> get props => [];
}

class StickerLoading extends StickerState {}

class StickerLoaded extends StickerState {
  final List<Sticker> stickers;

  StickerLoaded([this.stickers = const []]);

  @override
  List<Sticker> get props => stickers;

  @override
  String toString() => 'StickerLoaded Successful!';
}
