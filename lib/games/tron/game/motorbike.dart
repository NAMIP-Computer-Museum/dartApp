import 'dart:ui';
import 'package:collection/collection.dart';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum/games/tron/game/my_game.dart';

import '../../direction.dart';
import '../tron_game.dart';

class MotorBike extends SpriteComponent with HasGameRef<TronGame> {

  final int speed = 50;
  final Color color;
  List<Offset> points = [];
  List<List<int>> cases = [];

  final double _width = (850 * (MyGame.offset - 2)) / 450;
  final double _height = MyGame.offset - 2;

  MotorBike(this.color);

  @override
  Future<void>? onLoad() async {
    sprite = await Sprite.load("tron/motorbike/yellow_motorbike_left.png");
    width = _width;
    height = _height;
    //position = Vector2(30, (gameRef.size.x - GameBackground.padding)/2 - height/2);
    position = Vector2(_width/2, _height/2);
    points.add(position.toOffset());
    anchor = Anchor.center;
    return super.onLoad();
  }

  Direction lastDirectionForUpdate = Direction.right;

  @override
  void update(double dt) {
    if (points.isNotEmpty) {
      points.removeAt(points.length - 1);
    }
    if  (gameRef.motorbikeDirection != lastDirectionForUpdate && gameRef.motorbikeDirection != Direction.idle) {
      points.add(Offset(_getCase()[1] * MyGame.offset + MyGame.offset/2, _getCase()[0] * MyGame.offset + MyGame.offset/2));
      _getSprite();
    }
    points.add(position.toOffset());
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
    List<int> _case = _getCase();
    if (cases.isEmpty || !(const ListEquality().equals(cases.last, _case))) {
      if (_outOfBounds(_case[0]) || _outOfBounds(_case[1]) || gameRef.isOccupied[_case[0]][_case[1]]) {
        //gameRef.gameOver(); //TODO GameOver
        gameRef.motorbikeDirection = Direction.idle;
        //points = [];
      } else {
        cases.add(_case);
        gameRef.isOccupied[_case[0]][_case[1]] = true;
      }
    }
    super.update(dt);
  }

  List<int> _getCase() {
    return [(position.y / MyGame.offset).floor(), (position.x / MyGame.offset).floor()];
  }

  bool _outOfBounds(int c) {
    return c < 0 || c >= 30; //TODO MySharedPreferences
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromCenter(center: Offset(width/2, height/2), width: 1, height: 30), paint..color = BasicPalette.red.color);
    canvas.drawRect(Rect.fromCenter(center: Offset(width/2, height/2), width: 50, height: 1), paint..color = BasicPalette.red.color);
    super.render(canvas);
  }

  Future<void> _getSprite() async {
    switch (gameRef.lastDirection) {
      case Direction.right:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_right.png");
        width = _width;
        height = _height;
        y = _getCase()[0] * MyGame.offset + MyGame.offset/2;
        break;
      case Direction.left:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_left.png");
        width = _width;
        height = _height;
        y = _getCase()[0] * MyGame.offset + MyGame.offset/2;
        break;
      case Direction.up:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_up.png");
        width = _height;
        height = _width;
        x = _getCase()[1] * MyGame.offset + MyGame.offset/2;
        break;
      case Direction.down:
        sprite = await Sprite.load("tron/motorbike/yellow_motorbike_down.png");
        width = _height;
        height = _width;
        x = _getCase()[1] * MyGame.offset + MyGame.offset/2;
        break;
      default:
        break;
    }
  }
}