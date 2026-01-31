import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeService,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Enable dark theme'),
                secondary: const Icon(Icons.dark_mode), // Icône à gauche
                value: themeService.isDarkMode, // La valeur actuelle
                onChanged: (bool value) {
                  themeService.toggleTheme(); // L'action
                },
              ),

              const Divider(), // Une ligne de séparation

              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                subtitle: const Text('1.0.0'),
              ),
            ],
          ),
        );
      }
    );
  }
}