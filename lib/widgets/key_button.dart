import 'package:flutter/material.dart';

class KeyButton extends StatelessWidget {
  final String letter;
  final VoidCallback onTap;
  final double width;

  const KeyButton({
    super.key, 
    required this.letter, 
    required this.onTap,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 55,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          letter.toUpperCase(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}