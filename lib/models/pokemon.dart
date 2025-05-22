class Pokemon {
  final String name;
  final List<String> types;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.types,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
      hp: json['stats'][0]['base_stat'],
      attack: json['stats'][1]['base_stat'],
      defense: json['stats'][2]['base_stat'],
      specialAttack: json['stats'][3]['base_stat'],
      specialDefense: json['stats'][4]['base_stat'],
      speed: json['stats'][5]['base_stat'],
      imageUrl: json['sprites']['front_default'],
    );
  }
}
