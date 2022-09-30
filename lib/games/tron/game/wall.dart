import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/tron/game/motorbike.dart';

import '../tron_game.dart';

class Wall extends Component with HasGameRef<TronGame>, CollisionCallbacks {

  final MotorBike motorbike;
  List<RectangleHitbox> hitboxes = [];

  Wall(this.motorbike);

  @override
  void update(double dt) {
    for (Offset point in motorbike.points) {

    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..color = motorbike.color;
    paint.strokeWidth = 5;
    canvas.drawPoints(PointMode.polygon, motorbike.points, paint);
    super.render(canvas);
  }
}