import 'package:flutter/material.dart';
import 'package:flutter_pokemon/screens/start_game_screen.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/pokemon_elevated_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);
    final isCorrect =
        gameProvider.selectedAnswer == gameProvider.currentPokemon;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: _buildBody(context, gameProvider, isCorrect),
    );
  }

  Widget _buildBody(
      BuildContext context, GameProvider gameProvider, bool isCorrect) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            gameProvider.currentPokemon.imageUrl,
          ),
          const SizedBox(height: 20),
          _buildResultText(isCorrect, gameProvider),
          const SizedBox(height: 20),
          _buildPokemonStats(gameProvider),
          const SizedBox(height: 20),
          PokemonElevatedButton(
            onPressed: () => _navigateToStartScreen(context),
            title: 'Play Again',
          ),
        ],
      ),
    );
  }

  Widget _buildResultText(bool isCorrect, GameProvider gameProvider) {
    return Text(
      isCorrect
          ? 'You caught it! 🎉'
          : 'Oops! It was ${gameProvider.currentPokemon.name} 😅',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildPokemonStats(GameProvider gameProvider) {
    return Column(
      children: [
        Text('Name: ${gameProvider.currentPokemon.name}'),
        Text('Type: ${gameProvider.currentPokemon.types.join(', ')}'),
        Text('HP: ${gameProvider.currentPokemon.hp}'),
        Text('Attack: ${gameProvider.currentPokemon.attack}'),
        Text('Defense: ${gameProvider.currentPokemon.defense}'),
        Text('Special Attack: ${gameProvider.currentPokemon.specialAttack}'),
        Text('Special Defense: ${gameProvider.currentPokemon.specialDefense}'),
        Text('Speed: ${gameProvider.currentPokemon.speed}'),
      ],
    );
  }

  void _navigateToStartScreen(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const StartGameScreen()),
      (route) => false,
    );
  }
}
