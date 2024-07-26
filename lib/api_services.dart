import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_item.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('ApiService');

class ApiService {
  static const String _url = 'https://chroniclingamerica.loc.gov/search/titles/results/?terms=oakland&format=json&page=1';

  static Future<List<NewsItem>> fetchData() async {
    try {
      _logger.info('Sending GET request to $_url');
      final response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        _logger.info('Response received successfully');
        final data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        return items.map((item) => NewsItem.fromJson(item)).toList();
      } else {
        _logger.severe('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      _logger.severe('Network error: $e');
      throw Exception('Network error: $e');
    } on FormatException catch (e) {
      _logger.severe('Invalid JSON format: $e');
      throw Exception('Invalid JSON format: $e');
    } catch (e) {
      _logger.severe('An unknown error occurred: $e');
      throw Exception('An unknown error occurred: $e');
    }
  }
}
