import 'dart:async';
import 'dart:ui';

import 'package:curve/blocs/settings/settings_bloc.dart';
import 'package:curve/curve_game.dart';
import 'package:curve/game_components/curve_ball.dart';
import 'package:curve/overlays/game_over_menu.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

class GameCurve extends PositionComponent
    with HasGameRef<CurveGame>, FlameBlocReader<SettingsBloc, SettingsState> {
  late List<Offset> hitboxes;
  late Path path;
  late final int reps;
  late final int up;
  late final int down;
  late final int top;
  late final int bottom;
  late final int speed;

  @override
  Future<FutureOr<void>> onLoad() async {
    super.onLoad();
    reps = bloc.state.settings.reps;
    up = bloc.state.settings.up;
    down = bloc.state.settings.down;
    top = bloc.state.settings.top;
    bottom = bloc.state.settings.bottom;
    speed = bloc.state.settings.speed;
    path = getCurvePath();
    hitboxes = getHitboxesOffsets(path);
    hitboxes.forEach((offset) {
      final circle = CurveBall()..position = Vector2(offset.dx, offset.dy);
      add(circle);
    });
  }

  @override
  void update(double dt) {
    if (x <= -(gameRef.size.x)) {
      gameRef.canMovePlayer = true;
    }
    if (x < -(gameRef.size.x * (reps + 1))) {
      gameRef.overlays.add(GameOverMenu.id);
      gameRef.pauseEngine();
    }
    position.x -= (gameRef.size.x / speed) * dt;
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final path = getCurvePath();
    const curveWidth = 40.0; // Adjust the width of the curve as needed
    const curveColor = Colors.blue; // Adjust the color of the curve as needed

    final paint = Paint()
      ..color = curveColor
      ..strokeWidth = curveWidth
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);

    super.render(canvas);
  }

  Path getCurvePath() {
    final total = up + down + top + bottom;
    final width = gameRef.size.x;
    final height = gameRef.size.y * 0.3;
    final upWidth = (up / total) * width;
    final topWidth = (top / total) * width;
    final downWidth = (down / total) * width;
    final bottomWidth = (bottom / total) * width;
    final path = Path();
    path.moveTo(0, gameRef.size.y * 0.6);
    path.relativeLineTo(width, 0);
    path.relativeArcToPoint(const Offset(1, -1),
        clockwise: false, radius: const Radius.circular(1));
    for (int i = 0; i < reps; i++) {
      path.relativeLineTo(upWidth, -height);
      path.relativeArcToPoint(const Offset(1, -1),
          radius: const Radius.circular(1));
      path.relativeLineTo(topWidth, 0);
      path.relativeArcToPoint(const Offset(1, 1),
          radius: const Radius.circular(1));
      path.relativeLineTo(downWidth, height);
      path.relativeArcToPoint(const Offset(1, 1),
          clockwise: false, radius: const Radius.circular(1));
      path.relativeLineTo(bottomWidth, 0);
      if (i < reps - 1) {
        path.relativeArcToPoint(const Offset(1, -1),
            clockwise: false, radius: const Radius.circular(1));
      }
    }
    path.relativeLineTo(width, 0);
    return path;
  }

  getHitboxesOffsets(Path path) {
    List<Offset> ret = [];
    PathMetric pathMetrics = path.computeMetrics().first;
    double distance = 0.0; // Distance along the path

    while (distance < pathMetrics.length) {
      // Get the position on the path at the current distance
      final position = pathMetrics.getTangentForOffset(distance)?.position;
      if (position != null) {
        ret.add(position);
      }

      // Increase the distance to sample points at regular intervals
      double interval = 25.0; // Adjust the interval as per your requirement
      distance += interval;
    }
    return ret;
  }
}
