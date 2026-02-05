import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: premiumService,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            children: [
              // Section Premium
              if (!premiumService.isPremium) ...[
                Container(
                  color: Colors.amber.withOpacity(0.2), // Fond doré
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.orange),
                    title: const Text(
                      'Go Premium',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    subtitle: const Text('Remove limits & support the dev'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // SIMULATION D'ACHAT
                        premiumService.buyPremium();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Welcome to Premium! 🌟'),
                          ),
                        );
                      },
                      child: const Text('Buy'),
                    ),
                  ),
                ),
                const Divider(),
              ] else ...[
                Container(
                  color: Colors.green.withOpacity(0.1),
                  child: const ListTile(
                    leading: Icon(Icons.verified, color: Colors.green),
                    title: Text('Premium Unlocked'),
                    subtitle: Text('Thank you for your support! ❤️'),
                  ),
                ),
                const Divider(),
              ],

              // Section Dark Mode
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Enable dark theme'),
                secondary: const Icon(Icons.dark_mode),
                value: themeService.isDarkMode,
                onChanged: (bool value) {
                  themeService.toggleTheme();
                },
              ),

              const Divider(),

              // Section Version
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Version'),
                subtitle: const Text('1.0.0'),
              ),
            ],
          ),
        );
      },
    );
  }
}
