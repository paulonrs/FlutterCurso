import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_curso/domain/usecases/usecases.dart';

import 'package:flutter_curso/data/http/http.dart';
import 'package:flutter_curso/data/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  // Initializations
  late HttpClientSpy mockHttpClient;
  late String url;
  late RemoteAuthentication remoteAuthentication;

  // 1. Arrange
  setUp(() {
    mockHttpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    remoteAuthentication = RemoteAuthentication(
      httpClient: mockHttpClient,
      url: url,
    );
  });

  test("Shold call httpClient with correct values", () async {
    final params = AuthenticationParams(
        email: faker.internet.email(), password: faker.internet.password());

    // 2. Act
    await remoteAuthentication.auth(params);

    // 3. Assert
    verify(mockHttpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'password': params.password}));
  });
}
