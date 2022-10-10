import 'dart:math';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/tron/game/motorbike.dart';

import '../../direction.dart';
import 'my_game.dart';

class IaMotorbike extends MotorBike {

  String difficulty = "easy";

  static final Vector2 firstPosition = Vector2(MyGame.offset * (MyGame.nbCase - 3), MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2);
  static final Vector2 secondPosition = Vector2(MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2, MyGame.offset * 3);
  static final Vector2 thirdPosition = Vector2(MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2, MyGame.offset * (MyGame.nbCase - 3));

  static Vector2 nextPosition = firstPosition.clone();

  IaMotorbike(Color color) : super(color) {
    Direction d = nextPosition == firstPosition ? Direction.left : nextPosition == secondPosition ? Direction.down : Direction.up;
    lastDirection = d;
    lastDirectionForUpdate = d;
  }

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load("tron/motorbike/yellow_motorbike_${lastDirection.toString().substring(10)}.png");
    width = nextPosition == firstPosition ? motorbikeWidth : motorbikeHeight;
    height = nextPosition == firstPosition ? motorbikeHeight : motorbikeWidth;
    position = nextPosition;
    nextPosition = nextPosition == firstPosition ? secondPosition : nextPosition == secondPosition ? thirdPosition : firstPosition;
    points.add(position.toOffset());
    anchor = Anchor.center;
  }

  void updateDirection() {
    switch (difficulty) {
      case "easy":
        Direction? d = getEasyDirection();
        if (d != null) {
          direction = d;
          lastDirection = d;
        }
        break;
      default:
        break;
    }
  }

  @override
  void update(double dt) {
    if (gameRef.myGame.motorbike.direction == Direction.idle) {
      direction = Direction.idle;
    } else {
      if (direction == Direction.idle) updateDirection();
    }

    super.update(dt);
  }

  Direction? getEasyDirection() {
    List<Direction> directions = [];
    if (!outOfBounds(getCase()[0] - 1) && !gameRef.isOccupied[getCase()[0] - 1][getCase()[1]]) {
      if (lastDirection != Direction.down) directions.add(Direction.up);
    }
    if (!outOfBounds(getCase()[0] + 1) && !gameRef.isOccupied[getCase()[0] + 1][getCase()[1]]) {
      if (lastDirection != Direction.up) directions.add(Direction.down);
    }
    if (!outOfBounds(getCase()[1] - 1) && !gameRef.isOccupied[getCase()[0]][getCase()[1] - 1]) {
      if (lastDirection != Direction.right) directions.add(Direction.left);
    }
    if (!outOfBounds(getCase()[1] + 1) && !gameRef.isOccupied[getCase()[0]][getCase()[1] + 1]) {
      if (lastDirection != Direction.left) directions.add(Direction.right);
    }
    if (directions.isEmpty) {
      return null;
    }
    if (directions.contains(direction)) {
      for (int i = 0 ; i < 3 ; i++) {
        directions.add(direction);
      }
    }
    return directions[Random().nextInt(directions.length)];
  }
}