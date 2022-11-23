import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:nam_ip_museum/games/tron/game/motorbike.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';

import '../../direction.dart';
import 'my_game.dart';

class IaMotorbike extends MotorBike {

  String difficulty = MySharedPreferences.tronDifficulty;

  final Vector2 firstPosition = Vector2(MyGame.offset * (MyGame.nbCase - 3), MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2);
  final Vector2 secondPosition = Vector2(MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2, MyGame.offset * 3);
  final Vector2 thirdPosition = Vector2(MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2, MyGame.offset * (MyGame.nbCase - 3));

  static Vector2 nextPosition = Vector2(MyGame.offset * (MyGame.nbCase - 3), MyGame.nbCase~/2 * MyGame.offset + MyGame.offset/2);

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
      case "Easy":
        List<Direction>? directions = getEasyDirection(getCase());
        if (directions != null) {
          Direction d = directions[Random().nextInt(directions.length)];
          direction = d;
          lastDirection = d;
        }
        break;
      case "Medium":
        List<Direction>? directions = getMediumDirection(getCase());
        if (directions != null) {
          Direction d = directions[Random().nextInt(directions.length)];
          direction = d;
          lastDirection = d;
        }
        break;
      case "Hard":
        Direction? d = getHardDirection();
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

  List<Direction>? getEasyDirection(List<int> actualCase) {
    List<Direction> directions = [];
    if (!outOfBounds(actualCase[0] - 1) && !gameRef.isOccupied[actualCase[0] - 1][actualCase[1]]) {
      if (lastDirection != Direction.down) directions.add(Direction.up);
    }
    if (!outOfBounds(actualCase[0] + 1) && !gameRef.isOccupied[actualCase[0] + 1][actualCase[1]]) {
      if (lastDirection != Direction.up) directions.add(Direction.down);
    }
    if (!outOfBounds(actualCase[1] - 1) && !gameRef.isOccupied[actualCase[0]][actualCase[1] - 1]) {
      if (lastDirection != Direction.right) directions.add(Direction.left);
    }
    if (!outOfBounds(actualCase[1] + 1) && !gameRef.isOccupied[actualCase[0]][actualCase[1] + 1]) {
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
    return directions;
  }


  List<Direction>? getMediumDirection(List<int> actualCase) {
    List<Direction> possibleDirection = [];
    List<Direction>? directions = getEasyDirection(actualCase);
    if (directions == null) return null;
    for (Direction direction in directions) {
      switch (direction) {
        case Direction.up:
          List<Direction>? directions2 = getEasyDirection([actualCase[0] - 1, actualCase[1]]);
          if (directions2 != null) {
            for (int i = 0 ; i < directions2.length ; i++) {
              possibleDirection.add(direction);
            }
          }
          break;
        case Direction.down:
          List<Direction>? directions2 = getEasyDirection([actualCase[0] + 1, actualCase[1]]);
          if (directions2 != null) {
            for (int i = 0 ; i < directions2.length ; i++) {
              possibleDirection.add(direction);
            }
          }
          break;
        case Direction.left:
          List<Direction>? directions2 = getEasyDirection([actualCase[0], actualCase[1] - 1]);
          if (directions2 != null) {
            for (int i = 0 ; i < directions2.length ; i++) {
              possibleDirection.add(direction);
            }
          }
          break;
        case Direction.right:
          List<Direction>? directions2 = getEasyDirection([actualCase[0], actualCase[1] + 1]);
          if (directions2 != null) {
            for (int i = 0 ; i < directions2.length ; i++) {
              possibleDirection.add(direction);
            }
          }
          break;
        default:
          break;
      }
    }
    if (possibleDirection.isEmpty) {
      return directions;
    }
    return possibleDirection;
  }


  Direction? getHardDirection() {
    List<List<String>> isOccupied = gameRef.isOccupied.map((e) => e.map(
      (e) => e ? "wall" : "rien"
    ).toList()).toList(); /// Map avec des cases vides (à remplir), des murs (impossible d'y aller), les ennemis et l'ia
    List<Direction>? possibleDirection = getMediumDirection(getCase()); /// direction possible pour l'ia
    if (possibleDirection == null) return null;
    Map<Direction, int> directionScore = {}; /// score de chaque direction

    for (Direction direction in possibleDirection) { /// pour chaque direction possible
      int score = 0;
      isOccupied[gameRef.myGame.motorbike.getCase()[0]][gameRef.myGame.motorbike.getCase()[1]] = "ennemy"; /// on place le joueur sur la map
      for (IaMotorbike iaMotorbike in gameRef.myGame.iaMotorbikes) { /// on place les autres ia sur la map
        if (iaMotorbike != this) {
          isOccupied[iaMotorbike.getCase()[0]][iaMotorbike.getCase()[1]] = "ennemy";
        }
      }
      switch (direction) { /// on simule sur la map le deplacement de l'ia
        case Direction.up:
          isOccupied[getCase()[0] - 1][getCase()[1]] = "motorbike";
          break;
        case Direction.down:
          isOccupied[getCase()[0] + 1][getCase()[1]] = "motorbike";
          break;
        case Direction.left:
          isOccupied[getCase()[0]][getCase()[1] - 1] = "motorbike";
          break;
        case Direction.right:
          isOccupied[getCase()[0]][getCase()[1] + 1] = "motorbike";
          break;
        default:
          break;
      }
      int verifToNotLoopInfinitely = 0;
      bool ennemyFound = true;
      bool motorbikeFound = true;
      while(ennemyFound || motorbikeFound) { /// on check si un ennemi ou l'ia peut encore s'étendre
        verifToNotLoopInfinitely++;
        if (verifToNotLoopInfinitely > 1000) {
          print("On a bouclé infiniment");
          break;
        }
        /// on reset à faux
        ennemyFound = false;
        motorbikeFound = false;
        for (int i = 0 ; i < isOccupied.length ; i++) { /// on parcourt la map
          for (int j = 0 ; j < isOccupied[i].length ; j++) {
            if (isOccupied[i][j] == "ennemy") { /// on indique toutes les cases où les ennemis peuvent aller
              if (!outOfBounds(i - 1) && isOccupied[i - 1][j] == "rien") {
                isOccupied[i - 1][j] = "ennemy-en-route";
                ennemyFound = true;
              } else if (!outOfBounds(i + 1) && isOccupied[i + 1][j] == "rien") {
                isOccupied[i + 1][j] = "ennemy-en-route";
                ennemyFound = true;
              } else if (!outOfBounds(j - 1) && isOccupied[i][j - 1] == "rien") {
                isOccupied[i][j - 1] = "ennemy-en-route";
                ennemyFound = true;
              } else if (!outOfBounds(j + 1) && isOccupied[i][j + 1] == "rien") {
                isOccupied[i][j + 1] = "ennemy-en-route";
                ennemyFound = true;
              }
            }

            if (isOccupied[i][j] == "motorbike") { /// on indique toutes les cases où l'ia peut aller
              if (!outOfBounds(i - 1) && isOccupied[i - 1][j] == "rien") {
                isOccupied[i - 1][j] = "motorbike-en-route";
                motorbikeFound = true;
                score++;
              } else if (!outOfBounds(i + 1) && isOccupied[i + 1][j] == "rien") {
                isOccupied[i + 1][j] = "motorbike-en-route";
                motorbikeFound = true;
                score++;
              } else if (!outOfBounds(j - 1) && isOccupied[i][j - 1] == "rien") {
                isOccupied[i][j - 1] = "motorbike-en-route";
                motorbikeFound = true;
                score++;
              } else if (!outOfBounds(j + 1) && isOccupied[i][j + 1] == "rien") {
                isOccupied[i][j + 1] = "motorbike-en-route";
                motorbikeFound = true;
                score++;
              }
            }
          }
        }

        for (int i = 0 ; i < isOccupied.length ; i++) { /// on parcourt la map
          for (int j = 0 ; j < isOccupied[i].length ; j++) {
            if (isOccupied[i][j] == "ennemy-en-route") { /// on ajoute chaque case où l'ennemi peut aller en ennemi
              isOccupied[i][j] = "ennemy";
            }
            if (isOccupied[i][j] == "motorbike-en-route") { /// on ajoute chaque case où l'ia peut aller en ia
              isOccupied[i][j] = "motorbike";
            }
          }
        }
      }

      directionScore[direction] = score;
      /// on remet la map comme avant pour la prochaine direction
      isOccupied = isOccupied.map((e) => e.map(
              (e) => e == "wall" ? "wall" : "rien"
      ).toList()).toList();
    }

    return directionScore.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}