import 'dart:convert';
import 'dart:io';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_pet_nest/konstants/dataAccessors.dart';

class ApiCaller {
  static final String _baseUrl = FlavorConfig.instance!.variables!["baseUrl"];

  static Future<dynamic> get(String url, {bool withToken = false}) async {
    var responseJson;
    try {
      if (withToken) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final Map<String, String> header = {
          "Authorization": pref.getString(kDataToken) ?? ''
        };
        final response =
            await http.get(Uri.parse('$_baseUrl$url'), headers: header);
        responseJson = _returnResponse(response);
      } else {
        final response = await http.get(Uri.parse('$_baseUrl$url'));
        responseJson = _returnResponse(response);
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> post(String url, dynamic data,
      {bool withToken = false}) async {
    var responseJson;
    try {
      final Map<String, String> header = {"Content-Type": "application/json"};
      if (withToken) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        header["Authorization"] = pref.getString(kDataToken) ?? '';
      }
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
        return responseJson;
      case 400:
        throw Exception([response.statusCode, response.body.toString()]);
      case 401:
      case 403:
        throw Exception([response.statusCode, response.body.toString()]);
      case 500:
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
