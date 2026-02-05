import 'package:flutter/material.dart';
import 'dart:math';

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final double shakeOffset;
  final int count;
  final Duration duration;

  const ShakeWidget({
    super.key,
    required this.child,
    this.shakeOffset = 10.0, // Distance du tremblement
    this.count = 3, // Nombre d'allers-retours
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  ShakeWidgetState createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Le contrôleur d'animation
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // On ajoute un écouteur pour que l'animation s'arrête proprement
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // C'est cette méthode qu'on appellera depuis l'extérieur !
  void shake() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder redessine le widget à chaque frame de l'animation
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        // La magie mathématique pour faire un mouvement de sinus (gauche-droite)
        final sineValue = sin(widget.count * 2 * pi * _controller.value);

        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }
}
