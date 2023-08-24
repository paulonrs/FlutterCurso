import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_curso/domain/helpers/helpers.dart';
import 'package:flutter_curso/domain/usecases/usecases.dart';
import 'package:flutter_curso/data/http/http.dart';
import 'package:flutter_curso/data/usecases/usecases.dart';
import './../mocks/mocks.dart';

void main() {
  // Initializations
  late RemoteAuthentication remoteAuthentication;
  late HttpClientSpy mockHttpClient;
  late String url;
  late AuthenticationParams params;
  late Map apiResult;

  setUp(() {
    mockHttpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    remoteAuthentication = RemoteAuthentication(
      httpClient: mockHttpClient,
      url: url,
    );
    params = AuthenticationParams(
        email: faker.internet.email(), password: faker.internet.password());
    apiResult = {'accessToken': faker.guid.guid(), 'name': faker.person.name()};
    mockHttpClient.mockRequest(apiResult);
  });

  test("Shold call httpClient with correct values", () async {
    // 2. Act
    await remoteAuthentication.auth(params);

    // 3. Assert
    verify(() => mockHttpClient.request(
          url: url,
          method: 'post',
          body: params.toJson(),
        ));
  });

  test("Shold throw InvalidCredentialsError if HttpClient returns 401",
      () async {
    mockHttpClient.mockRequestError(HttpError.unauthorized);
    // 2. Act
    final future = remoteAuthentication.auth(params);

    // 3. Assert
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test("Shold throw UnexpectedError if HttpClient returns 400", () async {
    mockHttpClient.mockRequestError(HttpError.badRequest);
    // 2. Act
    final future = remoteAuthentication.auth(params);

    // 3. Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test("Shold throw UnexpectedError if HttpClient returns 404", () async {
    mockHttpClient.mockRequestError(HttpError.notFound);
    // 2. Act
    final future = remoteAuthentication.auth(params);

    // 3. Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test("Shold throw UnexpectedError if HttpClient returns 500", () async {
    mockHttpClient.mockRequestError(HttpError.serverError);
    // 2. Act
    final future = remoteAuthentication.auth(params);

    // 3. Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test("Shold return an Account if HttpClient returns 200", () async {
    final accessToken = faker.guid.guid();
    mockHttpClient
        .mockRequest({'accessToken': accessToken, 'name': faker.person.name()});
    // 2. Act
    final account = await remoteAuthentication.auth(params);

    // 3. Assert
    expect(account.token, accessToken);
  });

  test("Should return invalid token if HttpCliente returns 200", () async {
    mockHttpClient.mockRequest({'invalid_value': 'invalid_value'});
    // 2. Act
    final future = remoteAuthentication.auth(params);

    // 3. Assert
    expect(future, throwsException);
  });
}
