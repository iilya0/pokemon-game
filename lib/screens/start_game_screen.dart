import 'package:flutter/material.dart';
import 'package:flutter_pokemon/providers/game_provider.dart';
import 'package:flutter_pokemon/screens/rules_screen.dart';
import 'package:flutter_pokemon/widgets/pokemon_loading_indicator_widget.dart';
import 'package:flutter_pokemon/widgets/pokemon_elevated_button.dart';
import 'package:flutter_pokemon/widgets/pokemon_image_widget.dart';
import 'package:provider/provider.dart';

import 'game_screen.dart';

class StartGameScreen extends StatelessWidget {
  const StartGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, _) {
        if (gameProvider.gameStatus == GameStatus.loading) {
          return const LoadingIndicatorWidget();
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PokemonImageWidget(),
              const SizedBox(height: 40),
              const Text(
                'Who’s That Pokémon?',
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              _buildButtons(context, gameProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context, GameProvider gameProvider) {
    return Column(
      children: [
        PokemonElevatedButton(
          gameProvider: gameProvider,
          onPressed: () => _startGame(context, gameProvider),
          title: 'Start Round',
        ),
        const SizedBox(height: 30),
        PokemonElevatedButton(
          onPressed: () => _navigateToRulesScreen(context),
          title: 'Rules',
        ),
      ],
    );
  }

  void _navigateToRulesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RulesScreen()),
    );
  }

  void _startGame(BuildContext context, GameProvider gameProvider) async {
    await gameProvider.startGame();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GameScreen()),
    );
  }
}
