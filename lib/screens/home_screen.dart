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
  final List<String> currencies = ['USD', 'EUR', 'RUB', 'KZT'];

  String fromCurrency = 'USD';
  String toCurrency = 'KZT';

  double rate = 0;
  bool loading = true;

  final TextEditingController amountController =
      TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    loadRate();
  }

  Future<void> loadRate() async {
    setState(() => loading = true);

    try {
      final r =
          await CurrencyService.getRate(fromCurrency, toCurrency);

      setState(() {
        rate = r;
        loading = false;
      });
    } catch (_) {
      loading = false;
    }
  }

  double get convertedValue {
    final amount = double.tryParse(amountController.text) ?? 0;
    return amount * rate;
  }

  List<FlSpot> buildChartData(double rate) {
    return [
      FlSpot(1, rate - 5),
      FlSpot(5, rate - 3),
      FlSpot(10, rate - 1),
      FlSpot(15, rate),
      FlSpot(20, rate + 2),
      FlSpot(25, rate + 1),
      FlSpot(30, rate + 3),
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
                MaterialPageRoute(
                    builder: (_) => const ProfileScreen()),
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
                  /// ВЫБОР ВАЛЮТ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: fromCurrency,
                        items: currencies
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => fromCurrency = value!);
                          loadRate();
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.swap_horiz),
                      ),
                      DropdownButton<String>(
                        value: toCurrency,
                        items: currencies
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => toCurrency = value!);
                          loadRate();
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ГРАФИК
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * 0.4,
                    child: LineChart(
                      LineChartData(
                        minY: rate - 10,
                        maxY: rate + 10,
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 5,
                              getTitlesWidget: (value, _) =>
                                  Text(value.toInt().toString()),
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 5,
                              getTitlesWidget: (value, _) =>
                                  Text(value.toStringAsFixed(0)),
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: buildChartData(rate),
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

                  /// КОНВЕРТЕР
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade200,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: Colors.amber.shade700),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: amountController,
                          keyboardType:
                              TextInputType.number,
                          decoration: InputDecoration(
                            labelText:
                                'Сумма в $fromCurrency',
                          ),
                          onChanged: (_) =>
                              setState(() {}),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${convertedValue.toStringAsFixed(2)} $toCurrency',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
