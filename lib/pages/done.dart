import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class DonePage extends StatefulWidget {
  final String message;

  DonePage({required this.message});

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late SequenceAnimation _sequenceAnimation;

  @override
  void initState() {
    super.initState();

    // Configurar la animación
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween<double>(begin: 0, end: 1),
          from: Duration.zero,
          to: Duration(seconds: 1),
          tag: "fade_in",
        )
        .addAnimatable(
          animatable: Tween<double>(begin: 1, end: 0),
          from: Duration(seconds: 1),
          to: Duration(seconds: 2),
          tag: "fade_out",
        )
        .animate(_animationController);

    // Iniciar la animación
    _animationController.repeat(reverse: true);

    // Iniciar el temporizador de 20 segundos
    Timer(Duration(seconds: 1), () {
      // Redirigir a la página principal después de 20 segundos
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final fadeIn = _sequenceAnimation["fade_in"].value;
            final fadeOut = _sequenceAnimation["fade_out"].value;

            final opacity = fadeIn > fadeOut ? fadeIn : fadeOut;

            return Opacity(
              opacity: opacity,
              child: Text(widget.message),
            );
          },
        ),
      ),
    );
  }
}
