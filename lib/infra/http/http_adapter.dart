import 'dart:convert';

import '../helper/helper.dart';

import 'package:flutter_curso/data/http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpAdapter implements HttpClient {
  @override
  Future<Map>? request(
      {required String url,
      required String method,
      Map? body,
      Map? headers}) async {
    Response? response = Response("", 500);

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});

    Future<Response?>? request;

    try {
      if (method == 'post') {
        request = http.post(
          Uri.parse(url),
          headers: defaultHeaders,
          body: json.encode(body),
        );
      } else if (method == 'get') {
        request = http.get(
          Uri.parse(url),
          headers: defaultHeaders,
        );
      } else if (method == 'delete') {
        request = http.delete(
          Uri.parse(url),
          headers: defaultHeaders,
          body: json.encode(body),
        );
      } else if (method == 'put') {
        request = http.put(
          Uri.parse(url),
          headers: defaultHeaders,
          body: json.encode(body),
        );
      } else {
        throw Exception("Method Request not found");
      }

      response = await request;
    } catch (error) {
      throw HttpError.serverError;
    }

    return handleResponse(response!) as Map<dynamic, dynamic>;
  }
}
