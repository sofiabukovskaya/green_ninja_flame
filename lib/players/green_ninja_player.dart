import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:green_ninja_flame/constants/animation_configs.dart';
import 'package:green_ninja_flame/constants/globals.dart';
import 'package:green_ninja_flame/enums/attack_type.dart';

class GreenNinjaPlayer extends SimplePlayer {
  final double _damage = 10;

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

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {
      if (event.id == AttackType.melee ||
          event.id == LogicalKeyboardKey.numpad0.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;

        simpleAttackMelee(
          withPush: false,
          damage: _damage * 2,
          size: size,
          animationRight: AnimationConfigs.cutAnimation(),
        );
      }
      if (event.id == AttackType.range ||
          event.id == LogicalKeyboardKey.numpadEnter.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;

        simpleAttackRange(
            damage: _damage,
            animationRight: AnimationConfigs.shurikenAnimation(),
            animationLeft: AnimationConfigs.shurikenAnimation(),
            animationUp: AnimationConfigs.shurikenAnimation(),
            animationDown: AnimationConfigs.shurikenAnimation(),
            size: size);
      }
    }

    super.joystickAction(event);
  }
}
