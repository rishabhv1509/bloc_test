import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  String baseUrl = 'https://reqres.in/api';
  Future getUsers() async {
    String url = '$baseUrl/users';
    try {
      final result = await http.get(url);
      if (result.statusCode == 200) {
        var jsonResponse = json.decode(result.body);
        return jsonResponse;
      } else {
        var jsonResponse = jsonDecode(result.body);
        return jsonResponse;
      }
    } catch (e) {
      print('ERROR IN API SERVICE====>$e');
    }
  }

  Future ceateUser(Map<String, String> body) async {
    String url = '$baseUrl/register';
    try {
      final result = await http.post(url, body: body);
      if (result.statusCode == 200) {
        var jsonResponse = json.decode(result.body);
        return jsonResponse;
      } else {
        var jsonResponse = jsonDecode(result.body);
        return jsonResponse;
      }
    } catch (e) {
      print('ERROR IN API SERVICE OF CREATE USR====>$e');
    }
  }
}
