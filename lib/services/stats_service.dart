import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const String _keyGamesPlayed = 'games_played';
  static const String _keyGamesWon = 'games_won';
  static const String _keyCurrentStreak = 'current_streak';
  static const String _keyLastDailyDate = 'last_daily_date';
  static const String _keyLastFreeDate = 'last_free_date';
  static const String _keyFreeCount = 'free_count_today';

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

  static Future<bool> hasPlayedDaily() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_keyLastDailyDate);
    
    final today = DateTime.now().toIso8601String().split('T')[0];
    
    return lastDate == today;
  }

  static Future<void> markDailyPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    
    await prefs.setString(_keyLastDailyDate, today);
  }

  static Future<int> getFreeGamesPlayedToday() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_keyLastFreeDate);
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (lastDate != today) {
      return 0; 
    }

    return prefs.getInt(_keyFreeCount) ?? 0;
  }

  static Future<void> incrementFreeGame() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    
    int currentCount = await getFreeGamesPlayedToday();
    
    await prefs.setString(_keyLastFreeDate, today);
    await prefs.setInt(_keyFreeCount, currentCount + 1);
  }

  static Future<void> rewardExtraGame() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCount = await getFreeGamesPlayedToday();
    
    if (currentCount > 0) {
      await prefs.setInt(_keyFreeCount, currentCount - 1);
    }
  }
}