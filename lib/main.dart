import 'package:flutter/material.dart';

import 'welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namma Health',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B7A6E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
