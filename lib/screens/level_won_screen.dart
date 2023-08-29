import 'package:flutter/material.dart';
import 'package:green_ninja_flame/enums/map_id.dart';
import 'package:green_ninja_flame/games/green_ninja_game.dart';

class LevelWonScreen extends StatelessWidget {
  const LevelWonScreen({Key? key}) : super(key: key);

  static const String id = 'level_won';

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'You won, Green Ninja!',
                style: TextStyle(color: Colors.green, fontSize: 100),
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
