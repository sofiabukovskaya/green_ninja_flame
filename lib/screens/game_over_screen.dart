import 'package:flutter/material.dart';
import 'package:green_ninja_flame/enums/map_id.dart';
import 'package:green_ninja_flame/games/green_ninja_game.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key}) : super(key: key);

  static const String id = 'game_over';

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sorry, you lose.',
                style: TextStyle(color: Colors.red, fontSize: 100),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () => selectMap(MapId.one),
                child: const Text(
                  'Play again?',
                ),
              ),
            ],
          ),
        ),
      );
}
