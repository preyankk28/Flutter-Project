
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'api_urls.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ApiServiceCall {
  static const int TIME_OUT_DURATION = 60;


  Future<dynamic> getRequest({required String url}) async {
    try {
      final uri = "${ApiUrls.baseUrl}$url";
      final response = await http.get(
        Uri.parse(uri),
      ).timeout(const Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time');
    }
  }

  dynamic _processResponse(http.Response response) {
    final data = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
        return data;
      default:
        throw InvalidRequestException(data["error"]["message"] ?? response.reasonPhrase);
    }
  }
}
