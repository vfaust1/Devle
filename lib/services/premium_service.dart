import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PremiumService extends ChangeNotifier {
  static const String _keyPremium = 'is_premium_user';
  bool _isPremium = false;

  bool get isPremium => _isPremium;

  // Charger l'état au démarrage
  Future<void> loadPremiumStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_keyPremium) ?? false;
    notifyListeners();
  }

  // Simuler l'achat
  Future<void> buyPremium() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = true;
    await prefs.setBool(_keyPremium, true);
    notifyListeners();
  }

  // Pour les tests : Annuler l'achat
  Future<void> clearPremium() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = false;
    await prefs.remove(_keyPremium);
    notifyListeners();
  }
}
