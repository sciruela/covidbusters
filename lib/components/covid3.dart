import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:covidbusters/components/covid.dart';
import 'package:covidbusters/covidbusters-game.dart';

class Covid3 extends Covid {
  Covid3(CovidBustersGame game, double x, double y) : super(game) {
    spreadingSprite = List();
    spreadingSprite.add(Sprite('covids/covid3-1.png'));
    spreadingSprite.add(Sprite('covids/covid3-2.png'));
    deadSprite = Sprite('covids/covid3-dead.png');

    covidRect = Rect.fromLTWH(x, y, game.tileSize * 1, game.tileSize * 1);
  }

  double get speed => game.tileSize * 5;
}
