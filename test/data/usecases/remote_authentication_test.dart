import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_curso/domain/usecases/authentication.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = {'email': params.email, 'senha': params.senha};
    await httpClient.request(url: url, method: 'post', body: body);
  }
}

class HttpClient {
  Future<void>? request(
      {required String url, required String method, required Map body}) {
    return Future.value();
  }
}

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
        email: faker.internet.email(), senha: faker.internet.password());

    // 2. Act
    await remoteAuthentication.auth(params);

    // 3. Assert
    verify(mockHttpClient.request(
        url: url,
        method: 'post',
        body: {'email': params.email, 'senha': params.senha}));
  });
}
