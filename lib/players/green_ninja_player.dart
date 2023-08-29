import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_ninja_flame/constants/animation_configs.dart';
import 'package:green_ninja_flame/constants/collision_configs.dart';
import 'package:green_ninja_flame/constants/globals.dart';
import 'package:green_ninja_flame/enums/attack_type.dart';

class GreenNinjaPlayer extends SimplePlayer with ObjectCollision, UseBarLife {
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
        ) {
    setupBarLife(
      showLifeText: false,
      borderRadius: BorderRadius.circular(2),
      borderWidth: 2,
    );
    setupCollision(
      CollisionConfigs.playerCollisionConfig(),
    );
  }

  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    if (attacker == AttackFromEnum.ENEMY) {
      FlameAudio.play(Globals.explosionSound);
      showDamage(
        damage,
        config: TextStyle(fontSize: width / 3, color: Colors.red),
      );
    }
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  void die() {
    FlameAudio.play(Globals.gameOverSound);
    gameRef.camera.shake(intensity: 4);
    removeFromParent();
    super.die();
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {
      if (event.id == AttackType.melee ||
          event.id == LogicalKeyboardKey.digit1.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;

        simpleAttackMelee(
          withPush: false,
          damage: _damage * 2,
          size: size,
          animationRight: AnimationConfigs.cutAnimation(),
        );
      }
      if (event.id == AttackType.range ||
          event.id == LogicalKeyboardKey.digit2.keyId) {
        if (gameRef.player != null && gameRef.player?.isDead == true) return;

        simpleAttackRange(
            damage: _damage,
            animationRight: AnimationConfigs.shurikenMagicAnimation(),
            animationLeft: AnimationConfigs.shurikenMagicAnimation(),
            animationUp: AnimationConfigs.shurikenMagicAnimation(),
            animationDown: AnimationConfigs.shurikenMagicAnimation(),
            collision: CollisionConfigs.projectileCollisionConfig(
              width: width,
            ),
            size: size);
      }
    }

    super.joystickAction(event);
  }
}
