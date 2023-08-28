import 'package:bonfire/bonfire.dart';
import 'package:green_ninja_flame/constants/animation_configs.dart';
import 'package:green_ninja_flame/constants/globals.dart';

class GreenNinjaPlayer extends SimplePlayer {
  GreenNinjaPlayer(
      {required Vector2 position, required SpriteSheet spriteSheet})
      : super(
          size: Vector2(Globals.playerSize, Globals.playerSize),
          position: position,
          speed: 200,
          life: 100,
          initDirection: Direction.down,
          animation:
              AnimationConfigs.greenNinjaAnimation(spriteSheet: spriteSheet),
        );
}
