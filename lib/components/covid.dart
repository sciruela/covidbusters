import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

import 'package:covidbusters/covidbusters-game.dart';
import 'package:covidbusters/view.dart';

class Covid {
  final CovidBustersGame game;
  List<Sprite> spreadingSprite;
  Sprite deadSprite;
  double spreadingSpriteIndex = 0;
  Rect covidRect;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;


  Covid(this.game) {
    setTargetLocation();
  }

  double get speed => game.tileSize * 3;

  void render(Canvas c) {
    if (isDead) {
      deadSprite.renderRect(c, covidRect.inflate(covidRect.width / 2));
    } else {
      spreadingSprite[spreadingSpriteIndex.toInt()].renderRect(c, covidRect.inflate(covidRect.width / 2));
    }
  }

  void update(double t) {
    if (isDead) {
      covidRect = covidRect.translate(0, game.tileSize * 12 * t);

      if (covidRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      spreadingSpriteIndex += 30 * t;
      while (spreadingSpriteIndex >= 2) {
        spreadingSpriteIndex -= 2;
      }

      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(covidRect.left, covidRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
        covidRect = covidRect.shift(stepToTarget);
      } else {
        covidRect = covidRect.shift(toTarget);
        setTargetLocation();
      }

    }
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.tileSize * 1.35));
    double y = (game.rnd.nextDouble() * (game.screenSize.height - (game.tileSize * 2.85))) + (game.tileSize * 1.5);
    targetLocation = Offset(x, y);
  }

  void onTapDown() {
    if (!isDead) {
      if (game.soundButton.isEnabled) {
        Flame.audio.play('sfx/ouch' + (game.rnd.nextInt(11) + 1).toString() + '.ogg');
      }
      isDead = true;

      if (game.activeView == View.playing) {
        game.score += 1;

        if (game.score > (game.storage.getInt('highscore') ?? 0)) {
          game.storage.setInt('highscore', game.score);
          game.highScoreDisplay.updateHighscore();
        }
      }
    }
  }
}
