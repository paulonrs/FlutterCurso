import 'dart:convert';

import 'package:flutter_curso/data/http/http.dart';
import 'package:flutter_curso/infra/http/http.dart';

import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mocks.dart';

void main() {
  late ClientSpy client;
  late HttpAdapter httpAdapter;
  late String url;
  late Map<String, String> body = {"email": "user", "password": "password"};

  setUp(() => {
        client = ClientSpy(),
        httpAdapter = HttpAdapter(http: client),
      });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(Uri.parse(url));
  });
  group('post', () {
    const method = 'post';
    test("Should call request with correct values", () async {
      await httpAdapter.request(url: url, method: method, body: body);

      verify(() => client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: jsonEncode(body))).called(1);
    });

    test("Should return data if post returns 200 with data", () async {
      client.mockPost(200, body: jsonEncode(body));

      final response =
          await httpAdapter.request(url: url, method: method, body: body);

      expect(response, body);
    });
    test("Should return null if post returns 204", () async {
      client.mockPost(204);

      final response = await httpAdapter.request(url: url, method: method);

      expect(response, null);
    });

    test("Should return null if post returns 204 with data", () async {
      client.mockPost(204, body: jsonEncode(body));

      final response = await httpAdapter.request(url: url, method: method);

      expect(response, null);
    });

    test("Should return BadRequest if post returns 400 with invalid data",
        () async {
      client.mockPost(400, body: jsonEncode(body));

      final response = httpAdapter.request(url: url, method: method);

      expect(response, throwsA(HttpError.badRequest));
    });

    test("Should return unauthorized if post returns 401 with invalid data",
        () async {
      client.mockPost(401, body: jsonEncode(body));

      final response = httpAdapter.request(url: url, method: method);

      expect(response, throwsA(HttpError.unauthorized));
    });

    test("Should return notFound if post returns 404 with invalid data",
        () async {
      client.mockPost(404, body: jsonEncode(body));

      final response = httpAdapter.request(url: url, method: method);

      expect(response, throwsA(HttpError.notFound));
    });

    test("Should return forbidden if post returns 403 with invalid data",
        () async {
      client.mockPost(403, body: jsonEncode(body));

      final response = httpAdapter.request(url: url, method: method);

      expect(response, throwsA(HttpError.forbidden));
    });

    test("Should return serverError if post returns 500 with invalid data",
        () async {
      //
      client.mockPost(500, body: jsonEncode(body));

      final response = httpAdapter.request(url: url, method: method);

      expect(response, throwsA(HttpError.serverError));
    });
  });
}
