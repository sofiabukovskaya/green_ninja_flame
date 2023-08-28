import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_ninja_flame/constants/globals.dart';
import 'package:green_ninja_flame/enemies/dark_ninja_enemy.dart';
import 'package:green_ninja_flame/enums/attack_type.dart';
import 'package:green_ninja_flame/npcs/old_man.dart';
import 'package:green_ninja_flame/players/green_ninja_player.dart';
import 'package:green_ninja_flame/sprite_sheets/dark_ninja_sprite_sheet.dart';
import 'package:green_ninja_flame/sprite_sheets/green_ninja_sprite_sheet.dart';
import 'package:green_ninja_flame/sprite_sheets/old_man_sprite_sheet.dart';

class GreenNinjaGame extends StatefulWidget {
  const GreenNinjaGame({Key? key}) : super(key: key);

  @override
  State<GreenNinjaGame> createState() => _GreenNinjaGameState();
}

class _GreenNinjaGameState extends State<GreenNinjaGame> {
  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: Joystick(
        directional: JoystickDirectional(),
        keyboardConfig: KeyboardConfig(
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
          acceptedKeys: [
            LogicalKeyboardKey.numpadEnter,
            LogicalKeyboardKey.numpad0,
          ],
        ),
        actions: [
          JoystickAction(
            actionId: AttackType.melee,
            size: 80,
            margin: const EdgeInsets.only(
              bottom: 50,
              right: 50,
            ),
            align: JoystickActionAlign.BOTTOM_RIGHT,
            sprite: Sprite.load(
              Globals.sword,
            ),
          ),
          JoystickAction(
            actionId: AttackType.range,
            size: 50,
            margin: const EdgeInsets.only(
              bottom: 50,
              right: 160,
            ),
            sprite: Sprite.load(
              Globals.shurikenSingle,
            ),
          ),
        ],
      ),
      player: GreenNinjaPlayer(
          position: Vector2(40, 40),
          spriteSheet: GreenNinjaSpriteSheet.spriteSheet),
      map: WorldMapByTiled(
        Globals.mapOne,
        forceTileSize: Vector2(32, 32),
        objectsBuilder: {
          'old_man': (properties) => OldManNpc(
              position: properties.position,
              spriteSheet: OldManSpriteSheet.spriteSheet),
          'dark_ninja': (properties) => DarkNinjaEnemy(
                position: properties.position,
                spriteSheet: DarkNinjaSpriteSheet.spriteSheet,
              ),
        },
      ),
    );
  }
}
