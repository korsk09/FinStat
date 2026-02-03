import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'services/auth_service.dart';

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
        primaryColor: const Color.fromARGB(255, 22, 5, 117),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 57, 59, 197),
          secondary: const Color.fromARGB(255, 248, 216, 75),
        ),
        scaffoldBackgroundColor: Colors.blue.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 11, 24, 134),
          foregroundColor: Color.fromARGB(255, 252, 223, 98),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 233, 210, 108),
            foregroundColor: const Color.fromARGB(255, 17, 23, 102),
          ),
        ),
      ),

      home: FutureBuilder<bool>(
        future: AuthService.isRegistered(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.data == true) {
            return const HomeScreen();
          } else {
            return const RegisterScreen();
          }
        },
      ),
    );
  }
}
