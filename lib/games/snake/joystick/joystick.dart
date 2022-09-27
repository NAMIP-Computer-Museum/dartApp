import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:nam_ip_museum/games/snake/joystick/arrows/right_arrow.dart';
import 'package:nam_ip_museum/games/snake/joystick/arrows/up_arrow.dart';
import 'package:nam_ip_museum/games/snake/snake_game.dart';

import 'arrows/down_arrow.dart';
import 'arrows/left_arrow.dart';

class Joystick extends PositionComponent with HasGameRef<SnakeGame> {

  @override
  Future<void>? onLoad() async {
    //https://www.flaticon.com/search?type=icon&word=arrow+down&license=&color=&shape=&current_section=&author_id=&pack_id=&family_id=&style_id=&choice=&type=
    await add(RightArrow());
    await add(LeftArrow());
    await add(UpArrow());
    await add(DownArrow());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final size = gameRef.size;
    final x = size.x;
    final y = size.y;
    final Offset center = Offset(x/2, (y+x)/2);
    final double rayon = x/4;
    final paint = Paint()
      ..shader = Gradient.radial(center, rayon, [const Color(0xfff12711), const Color(0xfff5af19)]); //https://uigradients.com/#Flare

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

    canvas.drawPoints(PointMode.lines, [Offset(0, x), Offset(x, x)], paint2);
    super.render(canvas);
  }
}