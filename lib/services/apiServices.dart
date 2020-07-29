import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  String baseUrl = 'https://jsonplaceholder.typicode.com';
  Future getPosts(int start, int end) async {
    String url = '$baseUrl/posts?_start=$start&_limit=$end';
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
}
