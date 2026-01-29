import 'package:flutter/material.dart';
import '../widgets/letter_tile.dart';
import '../widgets/key_button.dart';

enum GameStatus { playing, won, lost }

class DailyWordScreen extends StatefulWidget {
  const DailyWordScreen({super.key});

  @override
  State<DailyWordScreen> createState() => _DailyWordScreenState();
}

class _DailyWordScreenState extends State<DailyWordScreen> {
  GameStatus gameStatus = GameStatus.playing;

  String currentGuess = "";
  int currentRow = 0;
  List<String> guesses = [];
  
  final String targetWord = "LINUX";

  void _onKeyTapped(String letter) {
    if (gameStatus != GameStatus.playing) return;
    if (currentGuess.length >= 5) return;

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

    if (currentGuess.length < 5) {
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
        _showEndGameMessage(true);
      }

      else if (guesses.length >= 6) {
        gameStatus = GameStatus.lost;
        _showEndGameMessage(false);
      }

      else {
        currentRow ++;
        currentGuess = "";
      }

    });
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
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Word')),
      body: Center(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(6, (rowIndex) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (letterIndex) {
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
    );
  }
}