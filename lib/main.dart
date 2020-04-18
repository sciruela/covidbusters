import 'package:covidbusters/covidbusters-game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/util.dart';
import 'package:flame/flame.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>[
    'bg/background.png',
    'bg/infected.png',
    'splash/title.png',
    'ui/dialog-help.png',
    'ui/icon-help.png',
    'ui/start-button.png',
    'ui/icon-music-enabled.png',
    'ui/icon-music-disabled.png',
    'ui/icon-sound-enabled.png',
    'ui/icon-sound-disabled.png',
    'covids/covid1-1.png',
    'covids/covid1-2.png',
    'covids/covid1-dead.png',
    'covids/covid2-1.png',
    'covids/covid2-2.png',
    'covids/covid2-dead.png',
    'covids/covid3-1.png',
    'covids/covid3-2.png',
    'covids/covid3-dead.png',
    'covids/covid4-1.png',
    'covids/covid4-2.png',
    'covids/covid4-dead.png',
    'covids/covid5-1.png',
    'covids/covid5-2.png',
    'covids/covid5-dead.png',
    'covids/covid6-1.png',
    'covids/covid6-2.png',
    'covids/covid6-dead.png'
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'bgm/home.mp3',
    'bgm/playing.mp3',
    'sfx/laugh1.ogg',
    'sfx/laugh2.ogg',
    'sfx/laugh3.ogg',
    'sfx/laugh4.ogg',
    'sfx/laugh5.ogg',
    'sfx/laugh6.ogg',
    'sfx/laugh7.ogg',
    'sfx/laugh8.ogg',
    'sfx/laugh9.ogg',
    'sfx/laugh10.ogg',
    'sfx/laugh11.ogg',
    'sfx/laugh12.ogg',
    'sfx/laugh13.ogg',
    'sfx/ouch1.ogg',
    'sfx/ouch2.ogg',
    'sfx/ouch3.ogg',
    'sfx/ouch4.ogg',
    'sfx/ouch5.ogg',
    'sfx/ouch6.ogg',
    'sfx/ouch7.ogg',
    'sfx/ouch8.ogg',
    'sfx/ouch9.ogg',
    'sfx/ouch10.ogg',
    'sfx/ouch11.ogg',
  ]);

  SharedPreferences storage = await SharedPreferences.getInstance();

 CovidBustersGame game = CovidBustersGame(storage);
 runApp(game.widget);

  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapper);
}
