import 'package:flutter/material.dart';
import 'package:flutter_pokemon/models/pokemon.dart';
import 'package:flutter_pokemon/widgets/pokemon_loading_indicator_widget.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/pokemon_elevated_button.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Who's That Pokémon?"),
        centerTitle: true,
      ),
      body: _buildBody(context, gameProvider),
    );
  }

  Widget _buildBody(BuildContext context, GameProvider gameProvider) {
    return gameProvider.options.isEmpty
        ? const LoadingIndicatorWidget()
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPokemonImage(gameProvider),
                const SizedBox(height: 80),
                _buildOptionButton(context, gameProvider),
              ],
            ),
          );
  }

  Widget _buildPokemonImage(GameProvider gameProvider) {
    return Image.network(
      gameProvider.currentPokemon.imageUrl,
      color: Colors.black.withOpacity(0.4),
      colorBlendMode: BlendMode.darken,
    );
  }

  Widget _buildOptionButton(BuildContext context, GameProvider gameProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: gameProvider.options.map((option) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 40,
            child: PokemonElevatedButton(
              onPressed: () =>
                  _navigateToResultScreen(context, gameProvider, option),
              title: option.name,
            ),
          );
        }).toList(),
      ),
    );
  }

  void _navigateToResultScreen(
      BuildContext context, GameProvider gameProvider, Pokemon option) {
    gameProvider.selectAnswer(option);
    Navigator.pushReplacementNamed(context, '/result');
  }
}
