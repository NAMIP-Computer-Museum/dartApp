import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/snake/game/game_background.dart';

import '../../direction.dart';
import '../tron_game.dart';

class MotorBike extends SpriteComponent with HasGameRef<TronGame>, CollisionCallbacks {

  final int speed = 100;
  final Color color;
  List<Offset> points = [];

  MotorBike(this.color);

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load("tron/yellow_motorbike.png");
    width = 19;
    height = 10;
    position = Vector2(30, (gameRef.size.x - GameBackground.padding)/2 - height/2);
    RectangleHitbox hitbox = RectangleHitbox(
      size: Vector2(width - 4, height - 4),
      position: Vector2(2, 2),
    );
    hitbox.debugMode = true;
    add(hitbox);
    return super.onLoad();
  }

  Direction lastDirectionForUpdate = Direction.right;

  @override
  void update(double dt) {
    if (points.isNotEmpty) {
      points.removeAt(points.length - 1);
    }
    points.add(_getBackPosition());
    if  (gameRef.motorbikeDirection != lastDirectionForUpdate && gameRef.motorbikeDirection != Direction.idle) {
      points.add(_getBackPosition());
    }
    lastDirectionForUpdate = gameRef.motorbikeDirection;
    switch(gameRef.motorbikeDirection) {
      case Direction.up:
        position.add(Vector2(0, -speed * dt));
        break;
      case Direction.down:
        position.add(Vector2(0, speed * dt));
        break;
      case Direction.left:
        position.add(Vector2(-speed * dt, 0));
        break;
      case Direction.right:
        position.add(Vector2(speed * dt, 0));
        break;
      default:
        break;
    }
    print(points.length);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    gameRef.motorbikeDirection = Direction.idle;
    print("Game Over");
    super.onCollision(intersectionPoints, other);
  }

  Offset _getBackPosition() {
    switch(gameRef.motorbikeDirection) {
      case Direction.up:
        return Offset(position.x + width/2, position.y + height);
      case Direction.down:
        return Offset(position.x + width/2, position.y);
      case Direction.left:
        return Offset(position.x + width, position.y + height/2);
      case Direction.right:
        return Offset(position.x, position.y + height/2);
      default:
        return Offset.zero;
    }
  }
}