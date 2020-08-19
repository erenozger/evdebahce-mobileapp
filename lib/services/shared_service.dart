import 'package:story/main.dart';

class SharedService {
  
  
  saveLogin(userToken) async {
    localStorage.setBool('is_login', true);
    localStorage.setString('user_token', userToken);
  }

  saveLogout(userToken) async {
    localStorage.setBool('is_login', false);
    localStorage.setString('user_token', null);
  }
}
