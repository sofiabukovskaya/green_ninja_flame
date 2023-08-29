import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:green_ninja_flame/constants/animation_configs.dart';
import 'package:green_ninja_flame/constants/globals.dart';
import 'package:green_ninja_flame/constants/collision_configs.dart';

class DemonEnemy extends SimpleEnemy
    with AutomaticRandomMovement, UseBarLife, ObjectCollision {
  bool _seePlayerToAttackMelee = false;
  final double _damage = 10;

  DemonEnemy({
    required Vector2 position,
  }) : super(
          size: Vector2(Globals.playerSize, Globals.playerSize),
          position: position,
          speed: 150,
          life: 50,
          initDirection: Direction.down,
          animation: AnimationConfigs.demonCyclopAnimation(),
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
    FlameAudio.play(Globals.explosionSound);
    showDamage(
      damage,
      config: TextStyle(fontSize: width / 3, color: Colors.red),
    );
    super.receiveDamage(attacker, damage, identify);
  }

  @override
  void die() {
    gameRef.camera.shake(intensity: 4);
    removeFromParent();
    super.die();
  }

  @override
  void update(double dt) {
    if (!gameRef.sceneBuilderStatus.isRunning) {
      _seePlayerToAttackMelee = false;

      seeAndMoveToPlayer(
        closePlayer: (player) {
          if (!player.isDead) {
            simpleAttackMelee(
              withPush: false,
              damage: _damage * 2,
              size: size,
              animationRight: AnimationConfigs.cutAnimation(),
            );
          }
        },
        radiusVision: Globals.radiusVision,
        observed: () {
          _seePlayerToAttackMelee = true;
        },
      );

      if (!_seePlayerToAttackMelee) {
        seeAndMoveToAttackRange(
          minDistanceFromPlayer: Globals.defaultTileSize * 4,
          positioned: (player) {
            if (!player.isDead) {
              simpleAttackRange(
                damage: _damage,
                animationRight: AnimationConfigs.fireBallAnimation(),
                animationDestroy: AnimationConfigs.smokeAnimation(),
                size: size,
                collision: CollisionConfigs.projectileCollisionConfig(
                  width: width,
                ),
              );
            }
          },
          radiusVision: Globals.radiusVision * 2,
          notObserved: () {
            runRandomMovement(
              dt,
              maxDistance: Globals.observeMaxDistance,
              minDistance: Globals.observeMinDistance,
            );
          },
        );
      }
    }
    super.update(dt);
  }
}
