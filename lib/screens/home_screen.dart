import 'package:devle/services/word_service.dart';
import 'package:flutter/material.dart';
import 'daily_word_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';
import '../services/stats_service.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDailyDone = false; 

  @override
  void initState() {
    super.initState();
    _checkDailyStatus();
  }

  Future<void> _checkDailyStatus() async {
    bool done = await StatsService.hasPlayedDaily();
    setState(() {
      isDailyDone = done;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "DEVLE",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 5),
            ),
            const SizedBox(height: 40),

            // BOUTON DAILY WORD
            ElevatedButton(
              onPressed: isDailyDone
                  ? null 
                  : () async {
                      String daily = WordService.getDailyWord();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DailyWordScreen(forcedWord: daily)),
                      );
                      _checkDailyStatus();
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: isDailyDone ? Colors.grey : null,
              ),
              child: Text(
                'Daily Word',
                style: const TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 20),

            // BOUTON FREE WORD
            ElevatedButton(
                onPressed: () async {
                  int played = await StatsService.getFreeGamesPlayedToday();
                  const int maxGames = 3;

                  if (played >= maxGames) {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Limit Reached 🛑"),
                          content: const Text(
                              "You have played your 3 free games for today.\n\nCome back tomorrow!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DailyWordScreen()),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Free Word', style: TextStyle(fontSize: 18))),

            const SizedBox(height: 20),

            // BOUTON STATS
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatsScreen()),
                  );
                },
                child: const Text('Stats')),

            const SizedBox(height: 20),

            // BOUTON SETTINGS
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
                  );
                },
                child: const Text('Settings')),
          ],
        ),
      ),
    );
  }
}