import 'package:flutter/material.dart';
import 'screens/main_screen.dart'; // ← point d'entrée avec la navigation

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(), // gère les 4 écrans + la BottomNavBar
    );
  }
}