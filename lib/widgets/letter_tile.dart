import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  final String letter;
  final Color backgroundColor;

  const LetterTile({
    super.key, 
    required this.letter,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: backgroundColor == Colors.transparent
            ? Border.all(color: Colors.grey)
            : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        letter.toUpperCase(),
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}