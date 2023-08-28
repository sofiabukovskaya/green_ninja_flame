import 'package:bonfire/bonfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_ninja_flame/constants/animation_configs.dart';
import 'package:green_ninja_flame/constants/globals.dart';

class DarkNinjaEnemy extends SimpleEnemy
    with AutomaticRandomMovement, UseBarLife {
  bool _observed = false;

  DarkNinjaEnemy({required Vector2 position, required SpriteSheet spriteSheet})
      : super(
          size: Vector2(Globals.playerSize, Globals.playerSize),
          position: position,
          speed: 100,
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
  }

  @override
  void update(double dt) {
    super.update(dt);

    seeAndMoveToPlayer(
      closePlayer: (player) {},
      radiusVision: Globals.radiusVision,
      observed: () {
        if (!_observed) {
          _observed = true;
        }
      },
      notObserved: () {
        _observed = false;
        runRandomMovement(
          dt,
          maxDistance: Globals.observeMaxDistance,
          minDistance: Globals.observeMinDistance,
        );
      },
    );
  }
}
