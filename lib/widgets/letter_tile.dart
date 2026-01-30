import 'package:flutter/material.dart';

class LetterTile extends StatelessWidget {
  final String letter;
  final Color backgroundColor;
  final double size;

  const LetterTile({
    super.key, 
    required this.letter,
    this.backgroundColor = Colors.transparent,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      margin: EdgeInsets.all(size * 0.05),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: backgroundColor == Colors.transparent
            ? Border.all(color: Colors.grey)
            : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        letter.toUpperCase(),
        style: TextStyle(
          fontSize: size * 0.5,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}