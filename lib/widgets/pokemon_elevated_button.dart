import 'package:flutter/material.dart';
import 'package:flutter_pokemon/providers/game_provider.dart';

class PokemonElevatedButton extends StatelessWidget {
  PokemonElevatedButton({super.key, this.gameProvider,  required this.onPressed, required this.title,});

  GameProvider? gameProvider;
  void Function() onPressed;
  String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(200, 50),
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        elevation: 8,
        shadowColor: Colors.black45,
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}