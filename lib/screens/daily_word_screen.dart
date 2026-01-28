import 'package:flutter/material.dart';
import '../widgets/letter_tile.dart';
import '../widgets/key_button.dart';

class DailyWordScreen extends StatelessWidget {
  const DailyWordScreen({super.key});

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
              ...List.generate(6, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0), 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (letterIndex) {
                      return const LetterTile(letter: '');
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
                      print("Lettre $e touchée");
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
                      print("Lettre $e touchée");
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row3.split('').map((e) {
                  return KeyButton(
                    letter: e,
                    onTap: () {
                      print("Lettre $e touchée");
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}