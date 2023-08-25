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

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.badRequest));
    });

    test("Should return unauthorized if post returns 401 with invalid data",
        () async {
      client.mockPost(401, body: jsonEncode(body));

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.unauthorized));
    });

    test("Should return notFound if post returns 404 with invalid data",
        () async {
      client.mockPost(404, body: jsonEncode(body));

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.notFound));
    });

    test("Should return forbidden if post returns 403 with invalid data",
        () async {
      client.mockPost(403, body: jsonEncode(body));

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.forbidden));
    });

    test("Should return serverError if post returns 500 with invalid data",
        () async {
      client.mockPost(500, body: jsonEncode(body));

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.serverError));
    });

    test('Should return ServerError if post throws', () async {
      client.mockPostError();

      final future = httpAdapter.request(url: url, method: 'post');

      expect(future, throwsA(HttpError.serverError));
    });
  });

  group('get', () {
    const method = 'get';
    test("Should request with correct values", () async {
      await httpAdapter.request(url: url, method: method);
      verify(() => client.get(
            Uri.parse(url),
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json'
            },
          )).called(1);

      await httpAdapter.request(
          url: url, method: 'get', headers: {'any_header': 'any_value'});

      verify(() => client.get(Uri.parse(url), headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'any_header': 'any_value'
          }));
    });

    test("Should return data if returns 200", () async {
      client.mockGet(200, body: jsonEncode(body));
      final response = await httpAdapter.request(url: url, method: method);
      expect(response, body);
    });

    test("Should return null if returns 200 with no data", () async {
      client.mockGet(200, body: "");
      final response = await httpAdapter.request(url: url, method: method);
      expect(response, null);
    });

    test("Should return BadRequest if get retuns 400", () async {
      client.mockGet(400);

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.badRequest));
    });

    test("Should return Unauthorized if get retuns 401", () async {
      client.mockGet(401);

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.unauthorized));
    });

    test("Should return forbidenn if get retuns 403", () async {
      client.mockGet(403);

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.forbidden));
    });

    test("Should return notFound if get retuns 404", () async {
      client.mockGet(404);

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.notFound));
    });

    test("Should return serverError if get retuns 500", () async {
      client.mockGet(500);

      expect(() async {
        await httpAdapter.request(url: url, method: method);
      }, throwsA(HttpError.serverError));
    });
  });
  group('put', () {
    const method = 'put';
    test("Should call put with correct values", () async {
      await httpAdapter.request(url: url, method: method, body: body);

      verify(() => client.put(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: jsonEncode(body)));
    });
    test("Should return the body if the returns contains values ", () async {
      client.mockPut(200, body: jsonEncode(body));

      final response =
          await httpAdapter.request(url: url, method: method, body: body);

      expect(response, body);
    });

    test("Should return null if the returns does not contain values", () async {
      client.mockPut(200, body: '');

      final response =
          await httpAdapter.request(url: url, method: method, body: body);

      expect(response, null);
    });

    test("Should return null if the returns 204", () async {
      client.mockPut(204, body: jsonEncode(body));

      final response =
          await httpAdapter.request(url: url, method: method, body: body);

      expect(response, null);
    });
  });
}
