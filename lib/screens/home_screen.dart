import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinStat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ---------- КОРОБОЧКА С НАДПИСЬЮ ----------
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100, // светлый синий фон
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade800), // обводка
              ),
              child: const Text(
                '\$ → ₸',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, // текст
                ),
              ),
            ),

            /// ---------- ГРАФИК ----------
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: LineChart(
                LineChartData(
                  minY: 4,
                  maxY: 6,
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _fakeCurrencyData(),
                      isCurved: true,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Container(
              width: 160,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.shade200, // желтая карточка
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.yellow.shade600),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '1 \$',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Icon(Icons.swap_horiz, color: Colors.blueAccent),
                  SizedBox(height: 4),
                  Text(
                    '480 ₸',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------- УСЛОВНЫЕ ДАННЫЕ КУРСА ----------
  static List<FlSpot> _fakeCurrencyData() {
    return const [
      FlSpot(1, 4.8),
      FlSpot(5, 4.9),
      FlSpot(10, 5.1),
      FlSpot(15, 5.0),
      FlSpot(20, 5.3),
      FlSpot(25, 5.4),
      FlSpot(30, 5.2),
    ];
  }
}
