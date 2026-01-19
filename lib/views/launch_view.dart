import 'package:flutter/material.dart';
import 'dart:async';
import 'home_view.dart'; // Importante para poder navegar

class LaunchView extends StatefulWidget {
  const LaunchView({super.key});

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  double _scale = 0.6;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _scale = 1.0;
        _opacity = 1.0;
      });
    });

    Timer(const Duration(milliseconds: 1800), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SizedBox.expand(
        // Ocupa todo el espacio disponible
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOut,
              opacity: _opacity,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOut,
                scale: _scale,
                child: const Icon(Icons.layers, size: 120, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1200),
              opacity: _opacity,
              child: const Text(
                "Cenco Movie test",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
