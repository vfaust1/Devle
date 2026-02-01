import 'package:devle/services/word_service.dart';
import 'package:flutter/material.dart';
// import '../widgets/letter_tile.dart';
import '../widgets/key_button.dart';
import 'package:flutter/services.dart';
import 'package:devle/services/stats_service.dart';
import '../widgets/shake_widget.dart';
import '../widgets/flip_letter_tile.dart';

enum GameStatus { playing, won, lost }

class DailyWordScreen extends StatefulWidget {
  final String? forcedWord;

  const DailyWordScreen({super.key, this.forcedWord});

  @override
  State<DailyWordScreen> createState() => _DailyWordScreenState();
}

class _DailyWordScreenState extends State<DailyWordScreen> {
  GameStatus gameStatus = GameStatus.playing;

  String currentGuess = "";
  int currentRow = 0;
  List<String> guesses = [];
  
  String targetWord = "";
  int _revealingIndex = -1;

  final FocusNode _focusNode = FocusNode();

  // Une clé unique pour chaque ligne (6 lignes max)
  final List<GlobalKey<ShakeWidgetState>> _shakeKeys = 
    List.generate(6, (index) => GlobalKey<ShakeWidgetState>());

  @override
  void initState() {
    super.initState();

    if (widget.forcedWord != null) {
      targetWord = widget.forcedWord!;
    } else {
      targetWord = WordService.getRandomWord();
    }
    print("Mode: ${widget.forcedWord != null ? 'DAILY' : 'FREE'} - Mot: $targetWord");
  }


  void _onKeyTapped(String letter) {
    if (gameStatus != GameStatus.playing) return;
    if (currentGuess.length >= targetWord.length) return;

    setState(() {
      currentGuess += letter;
    });
  }

  void _onBackspace() {
    if (gameStatus != GameStatus.playing) return;
    if (currentGuess.isEmpty) return;

    setState(() {
      currentGuess = currentGuess.substring(0, currentGuess.length - 1);
    });
  }

  Future<void> _onEnter() async {
    if (gameStatus != GameStatus.playing) return;

    // 1. Vérifications (Longueur + Dico)
    if (currentGuess.length < targetWord.length) {
      _shakeKeys[currentRow].currentState?.shake();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough letters!'), duration: Duration(seconds: 1)),
      );
      return;
    }

    if (!WordService.isValidWord(currentGuess)) {
      _shakeKeys[currentRow].currentState?.shake();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Word not in dictionary!'), backgroundColor: Colors.red, duration: Duration(seconds: 1)),
      );
      return;
    }

    // 2. ON LANCE LA SÉQUENCE DE RÉVÉLATION
    setState(() {
      guesses.add(currentGuess);
      _revealingIndex = -1;
    });

    // 3. Boucle d'animation
    for (int i = 0; i < targetWord.length; i++) {
      await Future.delayed(const Duration(milliseconds: 400)); // 300 ou 500 peut etre
      setState(() {
        _revealingIndex = i;
      });
    }

    // 4. Une fois l'animation finie, on vérifie la victoire/défaite
    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      _revealingIndex = -1;

      // Vérification victoire/défaite
      if (currentGuess == targetWord) {
        gameStatus = GameStatus.won;
        StatsService.saveGameResult(won: true);
        if (widget.forcedWord != null) {
          StatsService.markDailyPlayed();
        } else {
          StatsService.incrementFreeGame();
        }
        _showEndGameMessage(true);
      } 
      else if (guesses.length >= 6) {
        gameStatus = GameStatus.lost;
        StatsService.saveGameResult(won: false);
        if (widget.forcedWord != null) {
          StatsService.markDailyPlayed();
        } else {
          StatsService.incrementFreeGame();
        }
        _showEndGameMessage(false);
      } 
      // Préparation du prochain essai
      else {
        currentRow++;
        currentGuess = "";
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color _getTileColor(int rowIndex, int letterIndex) {
    // 1. Ligne future = transparente
    if (rowIndex > currentRow) {
      return Colors.transparent;
    }

    // 2. Ligne actuelle
    if (rowIndex == currentRow) {
      if (rowIndex >= guesses.length) {
        return Colors.transparent;
      }
      
      if (letterIndex > _revealingIndex) {
        return Colors.transparent;
      }
    }

    // 3. Calcul de la couleur 
    if (rowIndex >= guesses.length) return Colors.transparent;

    String guess = guesses[rowIndex];
    if (letterIndex >= guess.length) return Colors.transparent;

    String letter = guess[letterIndex];

    if (letter == targetWord[letterIndex]) {
      return Colors.green;
    } else if (targetWord.contains(letter)) {
      return Colors.amber;
    } else {
      return Colors.grey.shade800; 
    }
  }

  void _showEndGameMessage(bool won) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(won ? 'You Won!' : 'Game Over!'),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Important pour ne pas prendre tout l'écran
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(won
                  ? 'Congratulations! You found "$targetWord" in ${guesses.length} tries.'
                  : 'The word was "$targetWord". Better luck next time!'),
              const SizedBox(height: 20),
              
              const Text("Share your score:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.copy),
                  label: const Text("Copy Result to Clipboard"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    String textToShare = _generateShareText();
                    
                    Clipboard.setData(ClipboardData(text: textToShare));
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Score copied! Paste it anywhere.')),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Menu'),
            ),
             TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Stay here'),
            ),
          ],
        );
      }
    );
  }

  String _generateShareText() {
    StringBuffer buffer = StringBuffer();
    
    buffer.writeln('Devle ${DateTime.now().day}/${DateTime.now().month}');
    buffer.writeln('${guesses.length}/6');
    buffer.writeln();

    for (String guess in guesses) {
      for (int i = 0; i < guess.length; i++) {
        String letter = guess[i];
        
        if (letter == targetWord[i]) {
          buffer.write('🟩');
        } else if (targetWord.contains(letter)) {
          buffer.write('🟨');
        } else {
          buffer.write('⬛'); 
        }
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    const row1 = "AZERTYUIOP";
    const row2 = "QSDFGHJKL";
    const row3 = "WXCVBNM";

    double screenWidth = MediaQuery.of(context).size.width;

    double tileSize = (screenWidth - 40) / targetWord.length;
    if (tileSize > 60.0) tileSize = 60.0;

    double keyWidth = (screenWidth - 20) / 10;
    if (keyWidth > 45.0) keyWidth = 45.0;

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {

          // CAS 1 : Touche Entrée
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            _onEnter();
          }

          // CAS 2 : Touche Backspace / Delete
          else if (event.logicalKey == LogicalKeyboardKey.backspace || 
                   event.logicalKey == LogicalKeyboardKey.delete) {

            _onBackspace();
          }

          // CAS 3 : Lettres A-Z
          else if (event.character != null &&
                   event.character!.length == 1 &&
                   RegExp(r'^[a-zA-Z]$').hasMatch(event.character!)) {

            _onKeyTapped(event.character!.toUpperCase());
          }
        } 
      },

      child: Scaffold(
        appBar: AppBar(title: const Text('Daily Word')),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(6, (rowIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ShakeWidget(
                      key: _shakeKeys[rowIndex],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(targetWord.length, (letterIndex) {
                          String letterToShow = "";

                          if (rowIndex < currentRow) {
                            letterToShow = guesses[rowIndex][letterIndex];
                          } 
                          else if (rowIndex == currentRow) {
                            if (letterIndex < currentGuess.length) {
                              letterToShow = currentGuess[letterIndex];
                            }
                          } 

                          Color tileColor = _getTileColor(rowIndex, letterIndex);

                          return FlipLetterTile(
                            letter: letterToShow, 
                            backgroundColor: tileColor,
                            size: tileSize,
                          );
                        }),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row1.split('').map((e) {
                    return KeyButton(
                      letter: e,
                      width: keyWidth,
                      onTap: () {
                        _onKeyTapped(e);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row2.split('').map((e) {
                    return KeyButton(
                      letter: e,
                      width: keyWidth,
                      onTap: () {
                        _onKeyTapped(e);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KeyButton(
                      letter: 'ENT',
                      width: keyWidth * 1.5,
                      onTap: _onEnter,
                    ),
                    
                    ...row3.split('').map((e) {
                      return KeyButton(
                        letter: e,
                        width: keyWidth,
                        onTap: () => _onKeyTapped(e),
                      );
                    }),
                    KeyButton(
                      letter: 'DEL',
                      width: keyWidth * 1.5,
                      onTap: _onBackspace,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}