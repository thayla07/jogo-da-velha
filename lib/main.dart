import 'package:flutter/material.dart';
import 'jogo.dart'; // Import the JogoDaVelhaPage class

void main() {
  runApp(const JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  const JogoDaVelhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha', // App title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary theme color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const JogoDaVelhaPage(), // Initial screen of the game
    );
  }
}
