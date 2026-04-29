import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile/profile_page.dart';
import 'profile/controllers/profile_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProfileController())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mon Profil',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF6B35),
            primary: const Color(0xFFFF6B35),
          ),
          useMaterial3: true,
          fontFamily: 'SF Pro Display', // Utilise la police système iOS/Android
        ),
        home: const ProfilePage(),
      ),
    );
  }
}
