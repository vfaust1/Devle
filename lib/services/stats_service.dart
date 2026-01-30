import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const String _keyGamesPlayed = 'games_played';
  static const String _keyGamesWon = 'games_won';
  static const String _keyCurrentStreak = 'current_streak';

  // Récupérer toutes les stats d'un coup
  static Future<Map<String, int>> getStats() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'played': prefs.getInt(_keyGamesPlayed) ?? 0,
      'won': prefs.getInt(_keyGamesWon) ?? 0,
      'streak': prefs.getInt(_keyCurrentStreak) ?? 0,
    };
  }

  // Sauvegarder le résultat d'une partie
  static Future<void> saveGameResult({required bool won}) async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Mise à jour du nombre de parties
    int played = prefs.getInt(_keyGamesPlayed) ?? 0;
    await prefs.setInt(_keyGamesPlayed, played + 1);

    // 2. Mise à jour des victoires et du streak
    if (won) {
      int wins = prefs.getInt(_keyGamesWon) ?? 0;
      await prefs.setInt(_keyGamesWon, wins + 1);

      int streak = prefs.getInt(_keyCurrentStreak) ?? 0;
      await prefs.setInt(_keyCurrentStreak, streak + 1);
    } else {
      // Si perdu, le streak retombe à 0 !
      await prefs.setInt(_keyCurrentStreak, 0);
    }
  }
}