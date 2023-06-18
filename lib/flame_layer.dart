import 'package:curve/blocs/score/score_bloc.dart';
import 'package:curve/blocs/settings/settings_bloc.dart';
import 'package:curve/curve_game.dart';
import 'package:curve/overlays/game_over_menu.dart';
import 'package:curve/overlays/hud.dart';
import 'package:curve/overlays/main_menu.dart';
import 'package:curve/overlays/pause_menu.dart';
import 'package:curve/overlays/settings_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlameLayer extends StatelessWidget {
  const FlameLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GameWidget(
        // This will dislpay a loading bar until Game loads
        loadingBuilder: (context) => const Center(
          child: SizedBox(
            width: 200,
            child: LinearProgressIndicator(),
          ),
        ),
        // Register all the overlays that will be used by this game.
        overlayBuilderMap: {
          MainMenu.id: (_, CurveGame gameRef) => MainMenu(gameRef),
          PauseMenu.id: (_, CurveGame gameRef) => PauseMenu(gameRef),
          Hud.id: (_, CurveGame gameRef) => Hud(gameRef),
          GameOverMenu.id: (_, CurveGame gameRef) => GameOverMenu(gameRef),
          SettingsMenu.id: (_, CurveGame gameRef) => SettingsMenu(gameRef),
        },
        // By default MainMenu overlay will be active.
        initialActiveOverlays: const [MainMenu.id],
        game: CurveGame(
            settingsBloc: context.read<SettingsBloc>(),
            scoreBloc: context.read<ScoreBloc>()),
      ),
    );
  }
}
