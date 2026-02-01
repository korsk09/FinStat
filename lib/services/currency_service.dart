import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static Future<double> getRate(String from, String to) async {
    final url = Uri.parse('https://open.er-api.com/v6/latest/$from');

    final response = await http.get(url);
    final data = json.decode(response.body);

    return (data['rates'][to] as num).toDouble();
  }
}

