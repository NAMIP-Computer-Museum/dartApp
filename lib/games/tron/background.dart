import 'dart:ui';

import 'package:flame/components.dart';

import 'tron_game.dart';

class Background extends Component with HasGameRef<TronGame> {

  @override
  void render(Canvas canvas) {
    final Paint paint = Paint()..shader = Gradient.linear(
      const Offset(0, 0),
      Offset(gameRef.size.x, gameRef.size.y),
      <Color>[
        const Color(0xFF6FC3DF),
        const Color(0xFF0C141F),
      ],
    );
    canvas.drawRect(Rect.fromLTWH(0, 0, gameRef.size.x, gameRef.size.y), paint);
    super.render(canvas);
  }
}