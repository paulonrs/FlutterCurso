import '../entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String password;

  AuthenticationParams({required this.email, required this.password});

  Map toJson() => {'email': email, 'password': password};
}
