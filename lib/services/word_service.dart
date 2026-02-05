import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:math';

class WordService {
  // Une liste statique pour stocker les mots une fois chargés
  static List<String> _words = [];

  // Fonction pour charger le dictionnaire depuis le fichier
  static Future<void> loadDictionary() async {
    try {
      // 1. On lit le fichier brut en une seule longue chaine
      String fileContent = await rootBundle.loadString('assets/words.txt');

      // 2. On coupe à chaque saut de ligne pour faire une liste
      // LineSplitter gère les différences Windows/Mac (\r\n vs \n)
      _words = const LineSplitter().convert(fileContent);

      // 3. On filtre pour être sûr (majuscules, pas d'espaces, 5-6 lettres)
      _words = _words
          .map((w) => w.trim().toUpperCase())
          .where((w) => w.length == 5 || w.length == 6)
          .toList();

      print("Dictionnaire chargé : ${_words.length} mots.");
    } catch (e) {
      print("Erreur chargement dictionnaire : $e");
      // Fallback au cas où le fichier plante
      _words = ["ERROR", "FLUTTER"];
    }
  }

  // Pour récupérer un mot au hasard (Mode Free Word)
  static String getRandomWord() {
    if (_words.isEmpty) return "ERROR";

    final random = Random();
    int index = random.nextInt(_words.length);

    return _words[index];
  }

  static String getDailyWord() {
    if (_words.isEmpty) return "ERROR";

    final now = DateTime.now();
    final dayId = now.year * 10000 + now.month * 100 + now.day;
    final index = dayId % _words.length;

    return _words[index];
  }

  static bool isValidWord(String word) {
    return _words.contains(word.toUpperCase());
  }

  // Méthode uniquement pour les tests
  static void testSetWords(List<String> words) {
    _words = words;
  }
}
