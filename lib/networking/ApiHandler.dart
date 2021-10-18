import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHandler {
  static Future<Map<String, dynamic>> postApi({String baseUrl, String endApi, Map<String, dynamic> request}) async {
    var client = http.Client();
    var response = await client.post(Uri.parse(baseUrl + endApi), body: request);
    print("Response ${response.body.toString()}");

    Map<String, dynamic> mapResponse;

    try {
      if (response.statusCode == 200) {
        mapResponse = json.decode(response.body);
        return mapResponse;
      }
    } catch (e) {
      print("Exception caught ${e.toString()}");
    }
  }

  static Future<Map<String, dynamic>> getApi({String baseUrl, String endApi}) async {
    var client = http.Client();

    var response = await client.get(Uri.parse(baseUrl + endApi));

    Map<String, dynamic> mapResponse;

    try {
      if (response.statusCode == 200) {
        mapResponse = json.decode(response.body);
        return mapResponse;
      }
    } catch (e) {
      print("Exception caught ${e.toString()}");
    }
  }
}
