// This represents the pause menu overlay.
import 'dart:ui';

import 'package:curve/blocs/score/score_bloc.dart';
import 'package:curve/curve_game.dart';
import 'package:curve/overlays/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'hud.dart';

class PauseMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'PauseMenu';

  // Reference to parent game.
  final CurveGame gameRef;

  const PauseMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: BlocSelector<ScoreBloc, Score, int>(
                      selector: (state) => state.score,
                      builder: (_, score) {
                        return Text(
                          'Score: $score',
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(PauseMenu.id);
                      gameRef.overlays.add(Hud.id);
                      gameRef.resumeEngine();
                    },
                    child: const Text(
                      'Resume',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(PauseMenu.id);
                      gameRef.overlays.add(Hud.id);
                      gameRef.resumeEngine();
                      gameRef.reset();
                      gameRef.startGamePlay();
                    },
                    child: const Text(
                      'Restart',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(PauseMenu.id);
                      gameRef.overlays.add(MainMenu.id);
                      gameRef.resumeEngine();
                      gameRef.reset();
                    },
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
