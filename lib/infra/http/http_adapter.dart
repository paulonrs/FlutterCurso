import 'dart:convert';

import '../helper/helper.dart';

import 'package:flutter_curso/data/http/http.dart';

import 'package:http/http.dart';

class HttpAdapter implements HttpClient {
  final Client http;

  HttpAdapter({required this.http});

  @override
  Future<Map?> request(
      {required String url,
      required String method,
      Map? body,
      Map? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});
    final jsonBody = body != null ? jsonEncode(body) : null;

    method = method.toLowerCase();

    var response = Response('', 500);
    Future<Response>? futureResponse;

    try {
      if (method == 'post') {
        futureResponse = http.post(
          Uri.parse(url),
          headers: defaultHeaders,
          body: jsonBody,
        );
      } else if (method == 'get') {
        futureResponse = http.get(
          Uri.parse(url),
          headers: defaultHeaders,
        );
      } else if (method == 'delete') {
        futureResponse = http.delete(
          Uri.parse(url),
          headers: defaultHeaders,
          body: jsonBody,
        );
      } else if (method == 'put') {
        futureResponse = http.put(
          Uri.parse(url),
          headers: defaultHeaders,
          body: jsonBody,
        );
      } else {
        throw Exception("Method Request not found");
      }

      const timeToTimeOut = Duration(seconds: 10);
      response = await futureResponse.timeout(timeToTimeOut);
    } catch (error) {
      throw HttpError.serverError;
    }

    return handleResponse(response);
  }
}
