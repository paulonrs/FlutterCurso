import 'package:flutter_curso/domain/entities/account_entity.dart';
import 'package:flutter_curso/domain/usecases/usecases.dart';

import '../../domain/helpers/helpers.dart';
import '../http/http.dart';
import '../models/models.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  @override
  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromEntity(params).toJson();
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpResponse!).toEntity();
    } on HttpError catch (error) {
      if (error == HttpError.unauthorized) {
        throw DomainError.invalidCredentials;
      } else {
        throw DomainError.unexpected;
      }
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromEntity(AuthenticationParams params) =>
      RemoteAuthenticationParams(
          email: params.email, password: params.password);

  Map toJson() => {'email': email, 'password': password};
}
