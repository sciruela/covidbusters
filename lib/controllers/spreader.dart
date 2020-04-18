import 'package:covidbusters/covidbusters-game.dart';
import 'package:covidbusters/components/covid.dart';

class CovidSpreader {
  final CovidBustersGame game;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;

  int currentInterval;
  int nextSpread;

  CovidSpreader(this.game) {
    start();
    game.spreadCovid();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpread = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    game.covids.forEach((Covid covid) => covid.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingCovids = 0;
    game.covids.forEach((Covid covid) {
      if (!covid.isDead) livingCovids += 1;
    });

    if (nowTimestamp >= nextSpread && livingCovids < maxFliesOnScreen) {
      game.spreadCovid();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .02).toInt();
      }
      nextSpread = nowTimestamp + currentInterval;
    }
  }
}
