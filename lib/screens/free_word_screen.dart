import 'package:flutter/material.dart';

class FreeWordScreen extends StatelessWidget {
  const FreeWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Free Word')),
      body: const Center(
        child: Text('Grille du jeu ici'),
      ),
    );
  }
}