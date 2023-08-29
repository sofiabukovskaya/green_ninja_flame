import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:green_ninja_flame/constants/animation_configs.dart';
import 'package:green_ninja_flame/players/green_ninja_player.dart';
import 'package:green_ninja_flame/constants/globals.dart';
import 'package:green_ninja_flame/screens/level_won_screen.dart';

class Coin extends GameDecoration with Sensor<GreenNinjaPlayer> {
  Coin({
    required Vector2 position,
  }) : super.withAnimation(
          animation: AnimationConfigs.coinAnimation(),
          position: position,
          size: Vector2.all(Globals.smallItemSize),
        );

  @override
  void onContact(GameComponent component) {
    FlameAudio.play(Globals.successSound);
    removeFromParent();
    gameRef.pauseEngine();
    gameRef.overlayManager.add(
      LevelWonScreen.id,
    );
  }
}
