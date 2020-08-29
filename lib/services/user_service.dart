import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static updatePassword(current_password, new_password, token, email) async {
    final responsePassword = await http.post(
      'http://sedefbostanci.pythonanywhere.com/api/auth/password_change',
      body: {
        "current_password": current_password,
        "new_password": new_password,
        "token": token,
        "email": email,
      },
    );

    if (responsePassword.statusCode == 200) {
      final jsonData = json.decode(responsePassword.body);
      print(jsonData);
      return jsonData;
    } else {
      print("password degismedi! ");
      return null;
    }
  }
}
