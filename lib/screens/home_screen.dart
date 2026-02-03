import 'package:devle/main.dart';
import 'package:devle/services/word_service.dart';
import 'package:flutter/material.dart';
import 'daily_word_screen.dart';
import 'stats_screen.dart';
import 'settings_screen.dart';
import '../services/stats_service.dart'; 
import '../services/ad_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDailyDone = false; 
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _checkDailyStatus();
    _adService.loadRewardedAd();
  }

  Future<void> _checkDailyStatus() async {
    bool done = await StatsService.hasPlayedDaily();
    setState(() {
      isDailyDone = done;
    });
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
              style: TextStyle(
                fontSize: 40, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 5),
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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                disabledBackgroundColor: isDailyDone ? Colors.grey.shade300 : null,
                disabledForegroundColor: isDailyDone ? Colors.grey.shade600 : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Daily Word', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  
                  if (isDailyDone)
                    _buildBadge('DONE', Colors.green)
                  else
                    _buildBadge('NEW', Colors.redAccent),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BOUTON FREE WORD
            ElevatedButton(
                onPressed: () async {
                  // 1. Premium = accès illimité
                  if (premiumService.isPremium) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DailyWordScreen()),
                    );
                    return;
                  }

                  // 2. Verification du quota
                  int played = await StatsService.getFreeGamesPlayedToday();
                  const int maxGames = 3;

                  if (played >= maxGames) {
                    // QUOTA ATTEINT - DIALOGUE D'OPTION
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Limit Reached 🛑"),
                          content: const Text(
                              "You've used your 3 free games for today.\n\n"
                              "Watch an ad to play one more, or go Premium for unlimited access!",
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actionsOverflowDirection: VerticalDirection.up,
                          actions: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.star, color: Colors.white),
                              label: const Text("Go Premium (Unlimited)"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber[700],
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 45),
                              ),
                              onPressed: () {
                                Navigator.pop(context); 
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SettingsScreen()),
                                );
                              },
                            ),

                            const SizedBox(height: 8),

                            OutlinedButton.icon(
                              icon: const Icon(Icons.ondemand_video),
                              label: const Text("Watch Ad (+1 Game)"),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 45),
                              ),
                              onPressed: () async{
                                Navigator.pop(context); 
                                _adService.showRewardedAd(
                                  onRewardEarned: () async {
                                    await StatsService.rewardExtraGame();
                                    
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Thank You ! You have earned an extra game!"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const DailyWordScreen()),
                                      );
                                    }
                                  }
                                );
                              },
                            ),

                            // BOUTON ANNULER
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Close", style: TextStyle(color: Colors.grey)),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    // QUOTA NON ATTEINT
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
                child: const Text('Stats', style: TextStyle(fontSize: 18))),

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
                child: const Text('Settings', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }
}