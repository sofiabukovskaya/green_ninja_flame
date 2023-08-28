import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:green_ninja_flame/constants/globals.dart';
import 'package:green_ninja_flame/npcs/old_man.dart';
import 'package:green_ninja_flame/players/green_ninja_player.dart';
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
      joystick: Joystick(directional: JoystickDirectional()),
      player: GreenNinjaPlayer(
          position: Vector2(40, 40),
          spriteSheet: GreenNinjaSpriteSheet.spriteSheet),
      map: WorldMapByTiled(Globals.mapOne,
          forceTileSize: Vector2(32, 32),
          objectsBuilder: {
            'old_man': (properties) => OldManNpc(
                position: properties.position,
                spriteSheet: OldManSpriteSheet.spriteSheet)
          }),
    );
  }
}
