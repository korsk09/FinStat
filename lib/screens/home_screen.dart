import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'profile_screen.dart';
import '../services/currency_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? usdToKzt;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCurrency();
  }

  Future<void> loadCurrency() async {
    try {
      final rate = await CurrencyService.getUsdToKzt();

      setState(() {
        usdToKzt = rate;
        loading = false;
      });
    } catch (e) {
      loading = false;
    }
  }

  /// 📈 простая имитация графика от текущего курса
  List<FlSpot> buildChartData(double rate) {
    return [
      FlSpot(1, rate - 6),
      FlSpot(5, rate - 4),
      FlSpot(10, rate - 2),
      FlSpot(15, rate),
      FlSpot(20, rate + 1),
      FlSpot(25, rate - 1),
      FlSpot(30, rate + 2),
    ];
  }

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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  /// 🔵 НАПРАВЛЕНИЕ ВАЛЮТ
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade800),
                    ),
                    child: const Text(
                      '\$ → ₸',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 📊 ГРАФИК
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: LineChart(
                      LineChartData(
                        minY: usdToKzt! - 10,
                        maxY: usdToKzt! + 10,
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
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 5,
                              getTitlesWidget: (value, meta) {
                                return Text(value.toInt().toString());
                              },
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: buildChartData(usdToKzt!),
                            isCurved: true,
                            barWidth: 3,
                            dotData: FlDotData(show: false),
                            belowBarData:
                                BarAreaData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// 💛 КАРТОЧКА КУРСА
                  Container(
                    width: 170,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade200,
                      borderRadius: BorderRadius.circular(14),
                      border:
                          Border.all(color: Colors.yellow.shade700),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '1 \$',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Icon(Icons.swap_horiz,
                            color: Colors.blueAccent),
                        const SizedBox(height: 6),
                        Text(
                          '${usdToKzt!.toStringAsFixed(2)} ₸',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
