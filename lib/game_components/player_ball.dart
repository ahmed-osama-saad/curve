import 'package:curve/blocs/score/score_bloc.dart';
import 'package:curve/curve_game.dart';
import 'package:curve/game_components/curve_ball.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';

class PlayerBall extends PositionComponent
    with
        HasGameRef<CurveGame>,
        CollisionCallbacks,
        FlameBlocReader<ScoreBloc, Score> {
  late double yMax;
  double speedY = 0.0;
  bool isHit = false;
  Color _color = Colors.red;
  double joyStickSpeed = 5;
  final Timer _hitTimer = Timer(0.2);

  @override
  void onMount() {
    // First reset all the important properties, because onMount()
    // will be called even while restarting the game.
    _reset();
    // Add a hitbox.
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );
    yMax = gameRef.size.y * 0.8;

    // Set the callback for [_hitTimer].
    _hitTimer.onTick = () {
      _color = Colors.red;
      isHit = false;
    };
    super.onMount();
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = _color
      ..strokeWidth = 20
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 20, paint);
    super.render(canvas);
  }

  @override
  void update(double dt) {
    // if (gameRef.joystick.direction ==  JoystickDirection.up
    if (gameRef.canMovePlayer) {
      position.add(Vector2(0, gameRef.joystick.delta.y * joyStickSpeed * dt));
    }

    // The ball can never goes beyond [yMax].
    if (isBeyondYMax) {
      y = yMax;
      speedY = 0.0;
    }
    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if ((other is CurveBall)) {
      other.removeFromParent();
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    bloc.add(IncreaseScoreEvent());
    // speedY = 800;
    _hitTimer.start();
    isHit = true;
    _color = Colors.green;
  }

  // Returns true if  is on ground.
  bool get isBeyondYMax => (y >= yMax);

  // This method reset some of the important properties
  // of this component back to normal.
  void _reset() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(gameRef.size.x / 4, gameRef.size.y / 2);
    size = Vector2.all(24);
    isHit = false;
    speedY = 0.0;
  }
}
