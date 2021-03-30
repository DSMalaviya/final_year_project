import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HttpOperations {
  Future<Map> PostRequest(
      {@required File image, @required String urlEndpoint}) async {
    var uri = Uri.parse('http://10.0.2.2:5000/$urlEndpoint');
    // var uri = Uri.parse('https://192.168.1.6:5000/$urlEndpoint');
    final bytes = image.readAsBytesSync();
    Map<String, String> data = {'image': base64Encode(bytes)};

    var response = await http.post(uri, body: json.encode(data));
    Map<String, dynamic> responsedecode = json.decode(response.body);
    return responsedecode['prediction'];
  }
}
