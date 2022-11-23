import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';


import '../../direction.dart';
import '../tron_game.dart';
import 'arrows/down_arrow.dart';
import 'arrows/left_arrow.dart';
import 'arrows/right_arrow.dart';
import 'arrows/up_arrow.dart';

class Joystick extends PositionComponent with HasGameRef<TronGame>, Tappable {

  @override
  Future<void>? onLoad() async {
    size = Vector2.all(gameRef.size.x / 2);
    position = Vector2(gameRef.size.x / 2, (gameRef.size.y + gameRef.size.x) / 2);
    anchor = Anchor.center;
    //https://www.flaticon.com/search?type=icon&word=arrow+down&license=&color=&shape=&current_section=&author_id=&pack_id=&family_id=&style_id=&choice=&type=
    await add(RightArrow());
    await add(LeftArrow());
    await add(UpArrow());
    await add(DownArrow());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final Offset center = Offset(size.x/2, size.y/2);
    final double rayon = gameRef.size.x/4;
    final paint = Paint()
      ..shader = Gradient.radial(center, rayon, [const Color(0xFF6FC3DF), const Color(0xFF0C141F),]);

    canvas.drawCircle(center, rayon, paint);
    List<Offset> points = [];
    points.add(center);
    final a = (sqrt(2) / 2) * rayon;
    points.add(Offset(center.dx + a, center.dy + a));
    points.add(center);
    points.add(Offset(center.dx + a, center.dy - a));
    points.add(center);
    points.add(Offset(center.dx - a, center.dy + a));
    points.add(center);
    points.add(Offset(center.dx - a, center.dy - a));
    final paint2 = Paint()
      ..color = BasicPalette.white.color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPoints(PointMode.lines, points, paint2);

    super.render(canvas);
  }


  @override
  bool onTapDown(TapDownInfo info) {
    List<Offset> points = [Offset(0, -size.y/2), Offset(0, size.y/2), Offset(-size.x/2, 0), Offset(size.x/2, 0)].map((e) => e += position.toOffset()).toList();
    List<double> distances = points.map((e) => _distance(e, info.raw.localPosition)).toList();
    int index = distances.indexOf(distances.reduce(min));
    if (index != 2 && gameRef.myGame.motorbike.direction == Direction.idle) {
      gameRef.overlays.remove('SettingsButton');
      gameRef.overlays.add('PlayPauseButton');
    }
    switch (index) {
      case 0:
        if (gameRef.myGame.motorbike.lastDirection != Direction.down) {
          gameRef.myGame.motorbike.direction = Direction.up;
        }
        break;
      case 1:
        if (gameRef.myGame.motorbike.lastDirection != Direction.up) {
          gameRef.myGame.motorbike.direction = Direction.down;
        }
        break;
      case 2:
        if (gameRef.myGame.motorbike.lastDirection != Direction.right && gameRef.myGame.motorbike.lastDirection != Direction.idle) {
          gameRef.myGame.motorbike.direction = Direction.left;
        }
        break;
      case 3:
        if (gameRef.myGame.motorbike.lastDirection != Direction.left) {
          gameRef.myGame.motorbike.direction = Direction.right;
        }
        break;
    }
    return super.onTapDown(info);
  }

  double _distance(Offset a, Offset b) {
    return sqrt(pow(a.dx - b.dx, 2) + pow(a.dy - b.dy, 2));
  }
}