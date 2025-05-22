import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/game_provider.dart';
import 'screens/start_game_screen.dart';
import 'screens/game_screen.dart';
import 'screens/result_screen.dart';
import 'services/pokemon_service.dart';

void main() {
  runApp(MyApp(pokemonService: PokemonService()));
}

class MyApp extends StatelessWidget {
  final PokemonService pokemonService;

  const MyApp({super.key, required this.pokemonService});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameProvider(pokemonService),
      child: MaterialApp(
        title: 'Who’s That Pokémon?',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/start',
        routes: {
          '/start': (context) => const StartGameScreen(),
          '/game': (context) => const GameScreen(),
          '/result': (context) => const ResultScreen(),
        },
      ),
    );
  }
}
