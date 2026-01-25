import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1E3C),
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Верхняя панель ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "FinStat",
                    style: TextStyle(
                      color: Color(0xFFFFD79A),
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // КНОПКА НАЗАД
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF203A63),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFFFD79A),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ---------- Аватар ----------
            CircleAvatar(
              radius: 55,
              backgroundColor: const Color(0xFF203A63),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: const Color(0xFFFFD79A),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.brown.shade700,
                ),
              ),
            ),

            const SizedBox(height: 30),

            _profileButton("Name"),
            _profileButton("Email"),
            _profileButton("Settings"),

            const SizedBox(height: 25),

            // ---------- Нижняя панель ----------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF203A63),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.star, color: Color(0xFFFFD79A)),
                  const Text("\$",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  const Text("€",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  const Text("¥",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFD79A),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileButton(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFF203A63),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
