class UserModel {
  late final String email;
  late final String userName;
  late final String token;

  UserModel.fromJson(Map<String, dynamic> jsonData) {
    email = jsonData['Email'] ?? '';
    userName = jsonData['UserName'] ?? '';
    token = jsonData['Token'] ?? '';
  }
}
