import 'package:curve/blocs/score/score_bloc.dart';
import 'package:curve/blocs/settings/settings_bloc.dart';
import 'package:curve/game_components/game_curve.dart';
import 'package:curve/game_components/player_ball.dart';
import 'package:curve/overlays/game_over_menu.dart';
import 'package:curve/overlays/hud.dart';
import 'package:curve/overlays/pause_menu.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

class CurveGame extends FlameGame with HasCollisionDetection {
  CurveGame({required this.settingsBloc, required this.scoreBloc});
  SettingsBloc settingsBloc;
  ScoreBloc scoreBloc;
  late JoystickComponent joystick;
  late GameCurve _curve;
  late PlayerBall _player;
  bool canMovePlayer = false;

  static const _imageAssets = [
    'parallax/plx-1.png',
    'parallax/plx-2.png',
    'parallax/plx-3.png',
    'parallax/plx-4.png',
    'parallax/plx-5.png',
    'parallax/plx-6.png',
  ];
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Cache all the images.
    await images.loadAll(_imageAssets);
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(right: 40, bottom: 40),
      priority: 1,
    );
    add(joystick);

    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('parallax/plx-1.png'),
        ParallaxImageData('parallax/plx-2.png'),
        ParallaxImageData('parallax/plx-3.png'),
        ParallaxImageData('parallax/plx-4.png'),
        ParallaxImageData('parallax/plx-5.png'),
        ParallaxImageData('parallax/plx-6.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );
    add(parallaxBackground);
  }

  Future<void> startGamePlay() async {
    _player = PlayerBall();
    _curve = GameCurve();
    await add(FlameBlocProvider<SettingsBloc, SettingsState>.value(
        value: settingsBloc, children: [_curve]));
    await add(FlameBlocProvider<ScoreBloc, Score>.value(
        value: scoreBloc, children: [_player]));
  }

  // This method remove all the actors from the game.
  void _disconnectActors() {
    _player.removeFromParent();
    _curve.removeFromParent();
  }

  // This method reset the whole game world to initial state.
  void reset() {
    // First disconnect all actions from game world.
    _disconnectActors();
    canMovePlayer = false;
    scoreBloc.add(ResetScoreEvent());
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // On resume, if active overlay is not PauseMenu,
        // resume the engine (lets the parallax effect play).
        if (!(overlays.isActive(PauseMenu.id)) &&
            !(overlays.isActive(GameOverMenu.id))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        // If game is active, then remove Hud and add PauseMenu
        // before pausing the game.
        if (overlays.isActive(Hud.id)) {
          overlays.remove(Hud.id);
          overlays.add(PauseMenu.id);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
