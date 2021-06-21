import 'dart:convert';
import 'dart:io';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;

class ApiCaller {
  static final String _baseUrl = FlavorConfig.instance!.variables!["baseUrl"];

  static Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse('$_baseUrl$url'));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> post(String url, dynamic data) async {
    var responseJson;
    try {
      final Map<String, String> header = {"Content-Type": "application/json"};
      final response = await http.post(Uri.parse('$_baseUrl$url'),
          body: jsonEncode(data), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
