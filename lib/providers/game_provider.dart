import 'dart:math';
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

enum GameStatus {
  waiting,
  selection,
  correct,
  incorrect,
  loading,
  error,
}

class GameProvider with ChangeNotifier {
  final PokemonService _pokemonService;

  GameProvider(this._pokemonService);

  late Pokemon currentPokemon;
  late List<Pokemon> _options;

  GameStatus _gameStatus = GameStatus.waiting;
  Pokemon? _correctAnswer;
  Pokemon? _selectedAnswer;
  int _score = 0;
  int _streak = 0;

  GameStatus get gameStatus => _gameStatus;
  Pokemon? get correctAnswer => _correctAnswer;
  List<Pokemon> get options => _options;
  Pokemon? get selectedAnswer => _selectedAnswer;
  int get score => _score;
  int get streak => _streak;

  Future<void> startGame() async {
    _gameStatus = GameStatus.loading;
    notifyListeners();

    try {
      final random = Random();
      final int realPokemonId = random.nextInt(898) + 1;

      currentPokemon = await _pokemonService.fetchPokemon(realPokemonId);
      final distractors =
          await _pokemonService.fetchRandomPokemon(3, excludeId: realPokemonId);

      _options = [currentPokemon, ...distractors]..shuffle();
      _correctAnswer = currentPokemon;
      _selectedAnswer = null;
      _gameStatus = GameStatus.selection;
      notifyListeners();
    } catch (e) {
      _gameStatus = GameStatus.error;
      notifyListeners();
    }
  }

  void selectAnswer(Pokemon answer) {
    _selectedAnswer = answer;
    if (_selectedAnswer == _correctAnswer) {
      _score++;
      _streak++;
      _gameStatus = GameStatus.correct;
    } else {
      _streak = 0;
      _gameStatus = GameStatus.incorrect;
    }
    notifyListeners();
  }

  void resetGame() {
    _gameStatus = GameStatus.waiting;
    _correctAnswer = null;
    _options = [];
    _selectedAnswer = null;
    notifyListeners();
  }
}
