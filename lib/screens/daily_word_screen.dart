import 'package:devle/services/word_service.dart';
import 'package:flutter/material.dart';
import '../widgets/letter_tile.dart';
import '../widgets/key_button.dart';
import 'package:flutter/services.dart';
import 'package:devle/services/stats_service.dart';

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

  final FocusNode _focusNode = FocusNode();

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

  void _onEnter() {
    if (gameStatus != GameStatus.playing) return;

    if (currentGuess.length < targetWord.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough letters!'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    setState(() {
      guesses.add(currentGuess);

      if (currentGuess == targetWord) {
        gameStatus = GameStatus.won;

        StatsService.saveGameResult(won: true);
        _showEndGameMessage(true);
      }

      else if (guesses.length >= 6) {
        gameStatus = GameStatus.lost;

        StatsService.saveGameResult(won: false);
        _showEndGameMessage(false);
      }

      else {
        currentRow ++;
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
    if (rowIndex >= currentRow) {
      return Colors.transparent;
    }

    String guess = guesses[rowIndex];

    if (letterIndex >= guess.length) {
      return Colors.transparent;
    }

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
          title: Text(won ? 'You Won!' : 'You Lost!'),
          content: Text(won 
            ? 'Congratulations! You guessed the word "$targetWord" in ${guesses.length} tries' 
            : 'The correct word was "$targetWord". Better luck next time!'
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    const row1 = "AZERTYUIOP";
    const row2 = "QSDFGHJKL";
    const row3 = "WXCVBNM";

    double screenWidth = MediaQuery.of(context).size.width;
    double tileSize = (screenWidth - 40) / targetWord.length;
    if (tileSize > 60.0) tileSize = 60.0;

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

                        return LetterTile(
                          letter: letterToShow, 
                          backgroundColor: tileColor,
                          size: tileSize,
                        );
                      }),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: row1.split('').map((e) {
                    return KeyButton(
                      letter: e,
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
                      onTap: () {
                        _onKeyTapped(e);;
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
                      width: 55,
                      onTap: _onEnter,
                    ),
                    
                    ...row3.split('').map((e) {
                      return KeyButton(
                        letter: e,
                        onTap: () => _onKeyTapped(e),
                      );
                    }),
                    KeyButton(
                      letter: 'DEL',
                      width: 55,
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