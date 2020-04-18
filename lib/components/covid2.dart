import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covidbusters/components/covid.dart';
import 'package:covidbusters/covidbusters-game.dart';

class Covid2 extends Covid {
  Covid2(CovidBustersGame game, double x, double y) : super(game) {
    spreadingSprite = List();
    spreadingSprite.add(Sprite('covids/covid2-1.png'));
    spreadingSprite.add(Sprite('covids/covid2-2.png'));
    deadSprite = Sprite('covids/covid2-dead.png');

    covidRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
  }

  double get speed => game.tileSize * 5;
}
