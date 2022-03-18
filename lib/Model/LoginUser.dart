
import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  LoginUser({
    required this.success,
  });

  String success;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}
