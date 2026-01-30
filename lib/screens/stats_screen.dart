import 'package:flutter/material.dart';
import '../services/stats_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // Variables pour l'affichage
  int played = 0;
  int won = 0;
  int streak = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  // On charge les données au démarrage de l'écran
  Future<void> _loadStats() async {
    final stats = await StatsService.getStats();
    setState(() {
      played = stats['played']!;
      won = stats['won']!;
      streak = stats['streak']!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: isLoading 
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ligne des compteurs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem("Played", played),
                      _buildStatItem("Win %", played == 0 ? 0 : (won / played * 100).toInt()),
                      _buildStatItem("Streak", streak),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Petit bouton retour
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Menu'),
                  ),
                ],
              ),
            ),
    );
  }

  // Un petit widget helper pour faire joli
  Widget _buildStatItem(String label, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}