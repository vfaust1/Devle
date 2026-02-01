import 'package:flutter/material.dart';
import 'dart:math';

class FlipLetterTile extends StatefulWidget {
  final String letter;
  final Color backgroundColor;
  final double size;

  const FlipLetterTile({
    super.key,
    required this.letter,
    required this.backgroundColor,
    required this.size,
  });

  @override
  State<FlipLetterTile> createState() => _FlipLetterTileState();
}

class _FlipLetterTileState extends State<FlipLetterTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(FlipLetterTile oldWidget) {
    super.didUpdateWidget(oldWidget);
   
    if (oldWidget.backgroundColor == Colors.transparent && 
        widget.backgroundColor != Colors.transparent) {
      _controller.forward(from: 0.0);
    }
    
    if (widget.backgroundColor == Colors.transparent) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double angle = _flipAnimation.value * pi;
        
        bool isBack = angle >= (pi / 2);
        
        final transformAngle = isBack ? angle - pi : angle; 
        
        final Color currentColor = isBack ? widget.backgroundColor : Colors.transparent;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) 
            ..rotateX(transformAngle),
          alignment: Alignment.center,
          child: Container(
            width: widget.size,
            height: widget.size,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: currentColor, 
              borderRadius: BorderRadius.circular(4),
              border: !isBack 
                  ? Border.all(color: Theme.of(context).dividerColor, width: 2) 
                  : null, 
            ),
            child: Text(
              widget.letter,
              style: TextStyle(
                fontSize: widget.size * 0.5,
                fontWeight: FontWeight.bold,
                color: isBack 
                    ? Colors.white 
                    : Theme.of(context).brightness == Brightness.dark 
                        ? Colors.white 
                        : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}