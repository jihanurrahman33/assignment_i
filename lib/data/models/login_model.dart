

import 'package:assignment/data/models/user_model.dart';

class LoginModel {
  late final String token;
  late final UserModel userModel;
  LoginModel.fromJson(Map<String, dynamic> jsonData) {
    userModel = UserModel.fromJson(jsonData ?? {});
    token = jsonData['Token'] ?? '';
  }
}