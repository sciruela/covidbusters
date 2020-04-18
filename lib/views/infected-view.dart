import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covidbusters/covidbusters-game.dart';

class InfectedView {
  final CovidBustersGame game;
  Rect rect;
  Sprite sprite;

  InfectedView(this.game) {
    rect = Rect.fromLTWH(
      game.tileSize,
      (game.screenSize.height / 2) - (game.tileSize * 5),
      game.tileSize * 7,
      game.tileSize * 5,
    );
    sprite = Sprite('bg/infected.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void update(double t) {}
}
