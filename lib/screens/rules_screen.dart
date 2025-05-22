import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rules'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            _ruleItem('1. Click “Start Round” to start the game.'),
            _ruleItem('2. A picture of a Pokémon will appear on the screen.'),
            _ruleItem('3. Choose the right Pokémon name from four options.'),
          ],
        ),
      ),
    );
  }

  Widget _ruleItem(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
