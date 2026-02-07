import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prayer_app/core/utils/exceptions.dart';
import 'package:prayer_app/core/utils/logger.dart';

class HttpService {
  final http.Client _client;

  HttpService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      Logger.info('HTTP GET: $url');
      
      final response = await _client.get(
        Uri.parse(url),
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      Logger.error('HTTP GET failed: $url', e, stackTrace);
      throw NetworkException(
        'Failed to fetch data',
        originalError: e,
      );
    }
  }

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      Logger.info('HTTP POST: $url');
      
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
        body: body != null ? jsonEncode(body) : null,
      );

      return _handleResponse(response);
    } catch (e, stackTrace) {
      Logger.error('HTTP POST failed: $url', e, stackTrace);
      throw NetworkException(
        'Failed to post data',
        originalError: e,
      );
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw const ParseException('Failed to parse response');
      }
    } else if (response.statusCode == 404) {
      throw const NotFoundException('Resource not found');
    } else if (response.statusCode >= 500) {
      throw NetworkException(
        'Server error: ${response.statusCode}',
        code: response.statusCode.toString(),
      );
    } else {
      throw NetworkException(
        'Request failed: ${response.statusCode}',
        code: response.statusCode.toString(),
      );
    }
  }

  void dispose() {
    _client.close();
  }
}
