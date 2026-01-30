import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static Future<double> getUsdToKzt() async {
    final url = Uri.parse('https://open.er-api.com/v6/latest/USD');

    final response = await http.get(url);

    final data = json.decode(response.body);

    return (data['rates']['KZT'] as num).toDouble();
  }
}
