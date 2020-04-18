import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:covidbusters/components/background.dart';
import 'package:covidbusters/components/help-button.dart';
import 'package:covidbusters/components/start-button.dart';
import 'package:covidbusters/components/music-button.dart';
import 'package:covidbusters/components/sound-button.dart';
import 'package:covidbusters/components/score-display.dart';
import 'package:covidbusters/components/highscore-display.dart';
import 'package:covidbusters/components/covid.dart';
import 'package:covidbusters/components/covid1.dart';
import 'package:covidbusters/components/covid2.dart';
import 'package:covidbusters/components/covid3.dart';
import 'package:covidbusters/components/covid4.dart';
import 'package:covidbusters/components/covid5.dart';
import 'package:covidbusters/components/covid6.dart';

import 'package:covidbusters/controllers/spreader.dart';

import 'package:covidbusters/view.dart';
import 'package:covidbusters/views/home-view.dart';
import 'package:covidbusters/views/help-view.dart';
import 'package:covidbusters/views/infected-view.dart';

class CovidBustersGame extends Game {
  Size screenSize;
  double tileSize;
  Random rnd;
  int score;
  final SharedPreferences storage;

  Background background;
  List<Covid> covids;
  HelpButton helpButton;
  StartButton startButton;
  MusicButton musicButton;
  SoundButton soundButton;

  CovidSpreader spreader;


  View activeView = View.home;
  HomeView homeView;
  HelpView helpView;
  InfectedView infectedView;
  ScoreDisplay scoreDisplay;
  HighScoreDisplay highScoreDisplay;

  AudioPlayer homeBGM;
  AudioPlayer playingBGM;

  CovidBustersGame(this.storage) {
    initialize();
  }

  void initialize() async {
    score = 0;
    covids = List<Covid>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    background = Background(this);
    startButton = StartButton(this);
    musicButton = MusicButton(this);
    soundButton = SoundButton(this);
    scoreDisplay = ScoreDisplay(this);
    highScoreDisplay = HighScoreDisplay(this);

    spreader = CovidSpreader(this);

    homeView = HomeView(this);
    helpView = HelpView(this);
    infectedView = InfectedView(this);
    helpButton = HelpButton(this);

    homeBGM = await Flame.audio.loop('bgm/home.mp3', volume: .25);
    homeBGM.pause();
    playingBGM = await Flame.audio.loop('bgm/playing.mp3', volume: .25);
    playingBGM.pause();

    playHomeBGM();
  }

  void render(Canvas canvas) {
    background.render(canvas);
    highScoreDisplay.render(canvas);

    if (activeView == View.playing || activeView == View.infected) scoreDisplay.render(canvas);

    covids.forEach((Covid covid) => covid.render(canvas));

    if (activeView == View.home || activeView == View.infected) {
      startButton.render(canvas);
      helpButton.render(canvas);
    }
    musicButton.render(canvas);
    soundButton.render(canvas);
    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.infected) infectedView.render(canvas);
    if (activeView == View.help) helpView.render(canvas);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  @override
  void update(double t) {
    covids.forEach((Covid covid) => covid.update(t));
    covids.removeWhere((Covid covid) => covid.isOffScreen);
    spreader.update(t);
    if (activeView == View.playing) scoreDisplay.update(t);
  }
  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // dialog boxes
    if (!isHandled) {
      if (activeView == View.help) {
        activeView = View.home;
        isHandled = true;
      }
    }

    // start button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.infected) {
        startButton.onTapDown();
        playPlayingBGM();
        isHandled = true;
      }
    }

    // music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    // help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.infected) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    if (!isHandled) {
      bool didHitACovid = false;
      covids.forEach((Covid covid) {
        if (covid.covidRect.contains(d.globalPosition)) {
          covid.onTapDown();
          isHandled = true;
          didHitACovid = true;
        }
      });
      if (activeView == View.playing && !didHitACovid) {
       if (soundButton.isEnabled) {
          Flame.audio.play('sfx/laugh' + (rnd.nextInt(13) + 1).toString() + '.ogg');
        }
        playHomeBGM();
        activeView = View.infected;
      }
    }
  }

  void spreadCovid() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 1.35));
    double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.85))) + (tileSize * 1.5);
    switch (rnd.nextInt(6)) {
      case 0:
        covids.add(Covid1(this, x, y));
        break;
      case 1:
        covids.add(Covid2(this, x, y));
        break;
      case 2:
        covids.add(Covid3(this, x, y));
        break;
      case 3:
        covids.add(Covid4(this, x, y));
        break;
      case 4:
        covids.add(Covid5(this, x, y));
        break;
      case 5:
        covids.add(Covid6(this, x, y));
        break;
    }
  }
  void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() {
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }

}
