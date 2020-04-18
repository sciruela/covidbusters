import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covidbusters/components/covid.dart';
import 'package:covidbusters/covidbusters-game.dart';

class Covid4 extends Covid {
  Covid4(CovidBustersGame game, double x, double y) : super(game) {
    spreadingSprite = List();
    spreadingSprite.add(Sprite('covids/covid4-1.png'));
    spreadingSprite.add(Sprite('covids/covid4-2.png'));
    deadSprite = Sprite('covids/covid4-dead.png');

    covidRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
  }

  double get speed => game.tileSize * 5;
}
