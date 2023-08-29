import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_ninja_flame/constants/globals.dart';
import 'package:green_ninja_flame/decorations/fire.dart';
import 'package:green_ninja_flame/enemies/blue_ninja_enemy.dart';
import 'package:green_ninja_flame/enemies/dark_ninja_enemy.dart';
import 'package:green_ninja_flame/enemies/demon_enemy.dart';
import 'package:green_ninja_flame/enums/attack_type.dart';
import 'package:green_ninja_flame/enums/map_id.dart';
import 'package:green_ninja_flame/npcs/old_man.dart';
import 'package:green_ninja_flame/players/green_ninja_player.dart';
import 'package:green_ninja_flame/screens/game_over_screen.dart';
import 'package:green_ninja_flame/screens/level_won_screen.dart';
import 'package:green_ninja_flame/sprite_sheets/blue_ninja_sprite_sheet.dart';
import 'package:green_ninja_flame/sprite_sheets/dark_ninja_sprite_sheet.dart';
import 'package:green_ninja_flame/sprite_sheets/green_ninja_sprite_sheet.dart';
import 'package:green_ninja_flame/sprite_sheets/old_man_sprite_sheet.dart';

MapId currentMap = MapId.one;
late Function(MapId) selectMap;

class GreenNinjaGame extends StatefulWidget {
  const GreenNinjaGame({Key? key}) : super(key: key);

  @override
  State<GreenNinjaGame> createState() => _GreenNinjaGameState();
}

class _GreenNinjaGameState extends State<GreenNinjaGame> {
  @override
  void dispose() {
    currentMap = MapId.one;
    super.dispose();
  }

  @override
  void initState() {
    selectMap = (MapId id) {
      setState(
        () {
          currentMap = id;
        },
      );
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (currentMap) {
      case MapId.one:
      case MapId.two:
      case MapId.three:
      default:
        return BonfireWidget(
          overlayBuilderMap: {
            GameOverScreen.id: (context, game) => const GameOverScreen(),
            LevelWonScreen.id: (context, game) => const LevelWonScreen(),
            'mini_map': (context, game) => MiniMap(
                  game: game,
                  margin: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
          },
          initialActiveOverlays: const ['mini_map'],
          lightingColorGame: Colors.black.withOpacity(0.5),
          joystick: Joystick(
            directional: JoystickDirectional(),
            keyboardConfig: KeyboardConfig(
              keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
              acceptedKeys: [
                LogicalKeyboardKey.digit1,
                LogicalKeyboardKey.digit2,
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
              'blue_ninja': (properties) => BlueNinjaEnemy(
                    position: properties.position,
                    spriteSheet: BlueNinjaSpriteSheet.spriteSheet,
                  ),
              'demon': (properties) => DemonEnemy(
                    position: properties.position,
                  ),
              'fire': (properties) => Fire(position: properties.position),
            },
          ),
        );
    }
  }
}
