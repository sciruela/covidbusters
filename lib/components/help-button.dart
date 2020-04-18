import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covidbusters/covidbusters-game.dart';
import 'package:covidbusters/view.dart';

class HelpButton {
  final CovidBustersGame game;
  Rect rect;
  Sprite sprite;

  HelpButton(this.game) {
    rect = Rect.fromLTWH(
      ((game.screenSize.width - (game.tileSize * 1.25)) / 2) - game.tileSize ,
        game.screenSize.height - (game.tileSize * 1.25),
      game.tileSize * 3,
      game.tileSize,
    );
    sprite = Sprite('ui/icon-help.png');
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
  }

  void onTapDown() {
    game.activeView = View.help;
  }
}
