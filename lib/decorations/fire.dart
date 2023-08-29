import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:green_ninja_flame/constants/animation_configs.dart';
import 'package:green_ninja_flame/players/green_ninja_player.dart';
import 'package:green_ninja_flame/constants/globals.dart';

class Fire extends GameDecoration with Sensor<GreenNinjaPlayer>, Lighting {
  final double _damage = 5;

  Fire({
    required Vector2 position,
  }) : super.withAnimation(
          animation: AnimationConfigs.fireAnimation(),
          position: position,
          size: Vector2.all(Globals.smallItemSize),
        ) {
    setupLighting(
      LightingConfig(
        radius: width * 2,
        blurBorder: width * 2,
        color: Colors.yellow.withOpacity(0.1),
      ),
    );
  }

  @override
  void onContact(GameComponent component) {
    component = component as GreenNinjaPlayer;
    FlameAudio.play(Globals.fireSound);

    component.showDamage(_damage);
    component.removeLife(_damage);
  }
}
