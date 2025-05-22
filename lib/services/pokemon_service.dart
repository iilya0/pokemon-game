import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  static const _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<Pokemon> fetchPokemon(int id) async {
    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Pokemon.fromJson(data);
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  Future<List<Pokemon>> fetchRandomPokemon(int count, {int? excludeId}) async {
    final random = Random();
    final List<Pokemon> pokemonList = [];

    while (pokemonList.length < count) {
      final id = random.nextInt(898) + 1;
      if (id != excludeId) {
        final pokemon = await fetchPokemon(id);
        pokemonList.add(pokemon);
      }
    }

    return pokemonList;
  }
}
