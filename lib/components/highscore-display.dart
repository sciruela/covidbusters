import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:covidbusters/covidbusters-game.dart';

class HighScoreDisplay {
  final CovidBustersGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  HighScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 30,
      fontFamily: 'ComicSans',
      fontWeight: FontWeight.bold
    );

    position = Offset.zero;

    updateHighscore();
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }

  void updateHighscore() {
    int highscore = game.storage.getInt('highscore') ?? 0;

    painter.text = TextSpan(
      text: 'High-Score: ' + highscore.toString(),
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      game.screenSize.width - (game.tileSize * .25) - painter.width,
      game.tileSize * .25,
    );
  }
}
