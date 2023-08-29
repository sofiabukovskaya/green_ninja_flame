import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:green_ninja_flame/players/green_ninja_player.dart';
import 'package:green_ninja_flame/constants/globals.dart';

class Medipack extends GameDecoration with Sensor<GreenNinjaPlayer> {
  Medipack({
    required Vector2 position,
  }) : super.withSprite(
          sprite: Sprite.load(Globals.medipack),
          position: position,
          size: Vector2.all(Globals.smallItemSize),
        );

  final double _life = 25;

  @override
  void onContact(GameComponent component) {
    FlameAudio.play(Globals.powerUpSound);
    removeFromParent();
    gameRef.player!.addLife(_life);
  }
}
