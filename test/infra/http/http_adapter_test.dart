import 'dart:convert';

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
    test("Should call request with correct values", () async {
      await httpAdapter.request(url: url, method: 'post', body: body);

      verify(() => client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: jsonEncode(body))).called(1);
    });
  });
}
