import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 22, 5, 117), // главный синий цвет
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 57, 59, 197),
      secondary: const Color.fromARGB(255, 248, 216, 75), // желтый акцент
    ),
    scaffoldBackgroundColor: Colors.blue.shade50, // фон экрана
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 11, 24, 134),
      foregroundColor: const Color.fromARGB(255, 252, 223, 98), // текст и иконки AppBar
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 233, 210, 108),
        foregroundColor: const Color.fromARGB(255, 17, 23, 102),
      ),
    ),
  ),
  home: const HomeScreen(),
);

  }
}
