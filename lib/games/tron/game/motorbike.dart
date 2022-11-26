import 'dart:ui';
import 'package:collection/collection.dart';

import 'package:flame/components.dart';
import 'package:nam_ip_museum_web/games/tron/game/ia_motorbike.dart';
import 'package:nam_ip_museum_web/games/tron/game/my_game.dart';
import 'package:nam_ip_museum_web/utils/my_shared_preferences.dart';

import '../../direction.dart';
import '../tron_game.dart';

class MotorBike extends SpriteComponent with HasGameRef<TronGame> {

  final int speed = MySharedPreferences.tronSpeed;
  final Color color;
  List<Offset> points = [];
  List<List<int>> cases = [];

  final double motorbikeWidth = (850 * (MyGame.offset - 2)) / 450;
  final double motorbikeHeight = MyGame.offset - 2;
  
  Direction direction = Direction.idle;
  Direction lastDirection = Direction.right; //for sprite
  Direction lastDirectionForUpdate = Direction.right; //for update override method

  MotorBike(this.color);

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load("tron/motorbike/yellow_motorbike_right.png");
    width = motorbikeWidth;
    height = motorbikeHeight;
    position = Vector2(MyGame.offset * 3, MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2);
    points.add(position.toOffset());
    anchor = Anchor.center;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (points.isNotEmpty) {
      points.removeAt(points.length - 1);
    }
    if  (direction != lastDirectionForUpdate && direction != Direction.idle) {
      points.add(Offset(getCase()[1] * MyGame.offset + MyGame.offset/2, getCase()[0] * MyGame.offset + MyGame.offset/2));
      getSprite();
    }
    points.add(position.toOffset());
    lastDirectionForUpdate = direction;
    switch(direction) {
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
    List<int> actualCase = getCase();
    if (cases.isEmpty || !(const ListEquality().equals(cases.last, actualCase))) {
      if (outOfBounds(actualCase[0]) || outOfBounds(actualCase[1]) || gameRef.isOccupied[actualCase[0]][actualCase[1]]) {
        if (this is IaMotorbike) {
          gameRef.removeIaMotorbike(this as IaMotorbike);
        } else {
          gameRef.gameOver();
        }
        direction = Direction.idle;
        points = [];
        cases = [];
      } else {
        cases.add(actualCase);
        lastDirection = direction;
        gameRef.isOccupied[actualCase[0]][actualCase[1]] = true;
        if (this is IaMotorbike) {
          IaMotorbike ia = this as IaMotorbike;
          ia.updateDirection();
        }
      }
    }
    super.update(dt);
  }

  List<int> getCase() {
    return [(position.y / MyGame.offset).floor(), (position.x / MyGame.offset).floor()];
  }

  bool outOfBounds(int c) {
    return c < 0 || c >= MySharedPreferences.tronGridSize;
  }

  // @override
  // void render(Canvas canvas) {
  //   canvas.drawRect(Rect.fromCenter(center: Offset(width/2, height/2), width: 1, height: 30), paint..color = BasicPalette.red.color);
  //   canvas.drawRect(Rect.fromCenter(center: Offset(width/2, height/2), width: 50, height: 1), paint..color = BasicPalette.red.color);
  //   super.render(canvas);
  // }

  Future<void> getSprite() async {
    switch (direction) {
      case Direction.right:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_right.png");
        width = motorbikeWidth;
        height = motorbikeHeight;
        y = getCase()[0] * MyGame.offset + MyGame.offset/2;
        break;
      case Direction.left:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_left.png");
        width = motorbikeWidth;
        height = motorbikeHeight;
        y = getCase()[0] * MyGame.offset + MyGame.offset/2;
        break;
      case Direction.up:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_up.png");
        width = motorbikeHeight;
        height = motorbikeWidth;
        x = getCase()[1] * MyGame.offset + MyGame.offset/2;
        break;
      case Direction.down:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_down.png");
        width = motorbikeHeight;
        height = motorbikeWidth;
        x = getCase()[1] * MyGame.offset + MyGame.offset/2;
        break;
      default:
        break;
    }
  }
}