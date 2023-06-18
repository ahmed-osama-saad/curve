import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CurveBall extends PositionComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() {
    final hitbox =
        CircleHitbox.relative(1.5, parentSize: Vector2.all(20), isSolid: true)
          ..collisionType = CollisionType.passive;
    add(hitbox);

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 10, paint);
    super.render(canvas);
  }
}
