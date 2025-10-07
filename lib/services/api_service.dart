import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mini_job_portal/services/api_exception.dart';
import '../models/job.dart';

class ApiService {
  final http.Client _client;
  static const String _baseUrl = 'https://dummyjson.com';
  static const String _productsEndpoint = '/products';
  static const String _searchEndpoint = '/products/search';

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Job>> _fetchAndParseJobs(Uri url) async {
    try {
      final res = await _client.get(url);
      if (res.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(res.body);
        final List items = body['products'] ?? [];
        return items.map((e) => Job.fromApi(e)).toList();
      } else {
        throw ApiException(
          'Failed to load jobs. Please try again later.',
          res.statusCode,
        );
      }
    } on SocketException {
      throw ApiException('No Internet connection.');
    } on FormatException {
      throw ApiException('Bad response format.');
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<List<Job>> fetchJobs({int limit = 30}) async {
    final url = Uri.parse(
      '$_baseUrl$_productsEndpoint',
    ).replace(queryParameters: {'limit': limit.toString()});
    return _fetchAndParseJobs(url);
  }

  Future<List<Job>> searchJobs({required String query}) async {
    final url = Uri.parse(
      '$_baseUrl$_searchEndpoint',
    ).replace(queryParameters: {'q': query});
    return _fetchAndParseJobs(url);
  }
}
