import 'package:curve/blocs/score/score_bloc.dart';
import 'package:curve/curve_game.dart';
import 'package:curve/overlays/pause_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hud extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'Hud';

  // Reference to parent game.
  final CurveGame gameRef;

  const Hud(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocSelector<ScoreBloc, Score, int>(
            selector: (state) => state.score,
            builder: (_, score) {
              return TextButton(
                onPressed: () {},
                child: Text(
                  'Score: $score',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              gameRef.overlays.remove(Hud.id);
              gameRef.overlays.add(PauseMenu.id);
              gameRef.pauseEngine();
            },
            child: const Icon(Icons.pause, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
