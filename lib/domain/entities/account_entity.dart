class AccountEntity {
  final String token;

  AccountEntity(this.token);

  factory AccountEntity.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw Exception('Token invalid');
    }

    return AccountEntity(json['accessToken']);
  }
}
