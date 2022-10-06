import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/tron/game/motorbike.dart';

import '../../direction.dart';
import 'my_game.dart';

class IaMotorbike extends MotorBike {

  String difficulty = "easy";

  double clock = 0;

  IaMotorbike(Color color) : super(color) {
    lastDirection = Direction.left;
    lastDirectionForUpdate = Direction.left;
  }

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load("tron/motorbike/yellow_motorbike_left.png");
    width = motorbikeWidth;
    height = motorbikeHeight;
    position = Vector2(MyGame.offset * (MyGame.nbCase - 3), MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2);
    points.add(position.toOffset());
    anchor = Anchor.center;
  }

  void updateDirection() {
    switch (difficulty) {
      case "easy":
        Direction d = getEasyDirection();
        direction = d;
        lastDirection = d;
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
      clock += dt;
      if (clock > 0.1) {
        //print("clock${Random().nextInt(100)}");
        updateDirection();
        clock = 0;
      }
    }

    super.update(dt);
  }

  Direction getEasyDirection() {
    List<Direction> directions = [];
    if (!outOfBounds(getCase()[0] - 1) && !gameRef.isOccupied[getCase()[0] - 1][getCase()[1]]) {
      directions.add(Direction.up);
      if (direction == Direction.up) {
        directions.add(Direction.up);
        directions.add(Direction.up);
        directions.add(Direction.up);
        directions.add(Direction.up);
      }
    }
    if (!outOfBounds(getCase()[0] + 1) && !gameRef.isOccupied[getCase()[0] + 1][getCase()[1]]) {
      directions.add(Direction.down);
      if (direction == Direction.down) {
        directions.add(Direction.down);
        directions.add(Direction.down);
        directions.add(Direction.down);
        directions.add(Direction.down);
      }
    }
    if (!outOfBounds(getCase()[1] - 1) && !gameRef.isOccupied[getCase()[0]][getCase()[1] - 1]) {
      directions.add(Direction.left);
      if (direction == Direction.left) {
        directions.add(Direction.left);
        directions.add(Direction.left);
        directions.add(Direction.left);
        directions.add(Direction.left);
      }
    }
    if (!outOfBounds(getCase()[1] + 1) && !gameRef.isOccupied[getCase()[0]][getCase()[1] + 1]) {
      directions.add(Direction.right);
      if (direction == Direction.right) {
        directions.add(Direction.right);
        directions.add(Direction.right);
        directions.add(Direction.right);
        directions.add(Direction.right);
      }
    }
    if (directions.isEmpty) {
      return Direction.idle;
    }
    return directions[Random().nextInt(directions.length)];
  }
}