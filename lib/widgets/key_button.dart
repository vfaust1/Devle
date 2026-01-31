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
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 55,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.transparent : Colors.grey[200],
          border: Border.all(color: isDarkMode ? Colors.grey : Colors.grey.shade400,),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          letter.toUpperCase(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}