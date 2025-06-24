import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/models/login_model.dart';
import '../../../../data/services/network_client.dart';
import '../../../../data/utils/urls.dart';

class LoginController extends GetxController {
  String? token;
  bool _loginUserInProgress = false;
  bool get loginInProgress => _loginUserInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  Future<bool> loginUser(String email, String password) async {
    bool isSucess = false;
    _loginUserInProgress = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.login(userName: email, password: password),
    );

    if (response.isSucess) {
      LoginModel loginModel = LoginModel.fromJson(response.data!);
      isSucess = true;
      _errorMessage = null;
      await saveLoginToken(loginModel.token);
    } else {
      _errorMessage = response.errorMessage;
    }
    _loginUserInProgress = false;
    update();
    return isSucess;
  }

  //save login token locally
  Future<void> saveLoginToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', value);
  }
}
