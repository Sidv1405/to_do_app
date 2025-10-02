class AuthUserModel {
  final int id;
  final String token;

  AuthUserModel({required this.id, required this.token});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'token': token,
  };
}
