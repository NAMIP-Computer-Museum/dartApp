import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/tron/game/motorbike.dart';

import '../tron_game.dart';

class Wall extends Component with HasGameRef<TronGame>, CollisionCallbacks {

  final MotorBike motorbike;

  Wall(this.motorbike);

  @override
  void render(Canvas canvas) {
    Paint paint = Paint()..color = motorbike.color;
    paint.strokeWidth = 5;
    for (int i = 0; i < motorbike.points.length - 1; i++) {
      canvas.drawLine(motorbike.points[i], motorbike.points[i + 1], paint);
      if (i != 0) {
        double startAngle = _getAngle(motorbike.points[i-1], motorbike.points[i], motorbike.points[i + 1]);
        canvas.drawArc(Rect.fromCircle(center: motorbike.points[i], radius: 2.5), startAngle, pi/2, true, paint);
      }
    }
    super.render(canvas);
  }


  double _getAngle(Offset point1, Offset point2, Offset point3) {
    //pi/2 => bottom left
    //0 => bottom right
    //pi => top left
    //3*pi/2 => top right
    if (point1.dx == point2.dx && point1.dy <= point2.dy) {
      if (point2.dx <= point3.dx) {
        return pi / 2;
      } else {
        return 0;
      }
    } else if (point1.dx == point2.dx && point1.dy >= point2.dy) {
      if (point2.dx <= point3.dx) {
        return pi;
      } else {
        return 3 * pi / 2;
      }
    } else if (point1.dy == point2.dy && point1.dx <= point2.dx) {
      if (point2.dy <= point3.dy) {
        return 3 * pi / 2;
      } else {
        return 0;
      }
    } else if (point1.dy == point2.dy && point1.dx >= point2.dx) {
      if (point2.dy <= point3.dy) {
        return pi;
      } else {
        return pi / 2;
      }
    } else {
      return 0;
    }
  }
}