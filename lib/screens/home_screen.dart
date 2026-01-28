import 'package:flutter/material.dart';
import 'daily_word_screen.dart';
import 'free_word_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Devle')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DailyWordScreen()),
                );
              },
              child: const Text('Daily Word'),
            ),
            
            const SizedBox(height: 10),
            
            ElevatedButton(
               onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FreeWordScreen()),
                );
               }, 
               child: const Text('Free Word')
            ),

            const SizedBox(height: 10),

            ElevatedButton(
               onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StatsScreen()),
                );
               }, 
               child: const Text('Stats')
            ),

            const SizedBox(height: 10),

            ElevatedButton(
               onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
               }, 
               child: const Text('Settings')
            ),
          ],
        ),
      ),
    );
  }
}