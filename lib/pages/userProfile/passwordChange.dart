import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/models/user_model.dart';
import 'package:story/services/database_service.dart';
import 'package:story/services/user_service.dart';
import 'package:sweetalert/sweetalert.dart';

class PasswordChangePage extends StatefulWidget {
  final String currentUserMail;

  const PasswordChangePage({Key key, this.currentUserMail}) : super(key: key);
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _newPasswordController = TextEditingController();
  bool checkCurrentPasswordValid = true;
  String _currentPassword;
  String _newPassword;
  String _repeatPassword;
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Manage Password"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, size: 36),
                  labelText: 'Current Password',
                  errorText: checkCurrentPasswordValid
                      ? null
                      : "Please double check your current password",
                ),
                validator: (input) => input.length < 6 || input.contains(' ')
                    ? 'Password must be at least 6 characters'
                    : null,
                onSaved: (input) => _currentPassword = input,
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_open, size: 36),
                    labelText: 'New Password'),
                controller: _newPasswordController,
                obscureText: true,
                validator: (input) => input.length < 6 || input.contains(' ')
                    ? 'Password must be at least 6 characters'
                    : null,
                onSaved: (input) => _newPassword = input,
                //obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline, size: 36),
                  labelText: 'Repeat Password',
                ),
                validator: (value) {
                  return _newPasswordController.text == value
                      ? null
                      : "Please validate your entered password";
                },
                onSaved: (input) => _repeatPassword = input,
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 180.0,
              child: FlatButton(
                onPressed: () => _saveNewPassword(widget.currentUserMail),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                padding: EdgeInsets.all(10),
                child: Text(
                  'Save Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveNewPassword(String email) async {
    print("_saveNewPassword !!!");
    print(_currentPassword);

    Future<bool> validateCurrentPassword(String password) async {
      return await validatePassword(password);
    }

    if (_formKey2.currentState.validate()) {
      _formKey2.currentState.save();
      print(_currentPassword);
      print(_newPassword);
      print(_repeatPassword);
      checkCurrentPasswordValid =
          await validateCurrentPassword(_currentPassword);
      setState(() {});
      if (checkCurrentPasswordValid == true) {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "PASSWORD CHANGE",
          desc: "Do you want to change your password ? ",
          buttons: [
            DialogButton(
              child: Text(
                "YES",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                _saveNewPasswordStep2(email);
                Navigator.pop(context);
                SweetAlert.show(context,
                    subtitle: "Changing...", style: SweetAlertStyle.loading);

                new Future.delayed(new Duration(seconds: 2), () {
                  SweetAlert.show(context,
                      subtitle: "Success!", style: SweetAlertStyle.success);
                  Alert(
                    context: context,
                    title: "Password Changed",
                    desc: "You can log in with your new password.",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "OKEY",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.popUntil(
                            context, ModalRoute.withName('/')),
                        color: Color.fromRGBO(0, 179, 134, 1.0),
                        radius: BorderRadius.circular(0.0),
                      ),
                    ],
                    image: Image.network(
                        "https://scribbleghost.net/wp-content/uploads/2019/07/ScribbleGhost-Logo-White-PNG-558px.png"),
                  ).show();
                });
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
            DialogButton(
              child: Text(
                "CANCEL",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
            )
          ],
        ).show();
      } else {
        print("yanlıs pw");
      }
    }
  }

  Future<bool> validatePassword(String password) async {
    print(password);
    print("buraya girdi");
    var firebaseUser = await _auth.currentUser();

    var authCredentials = EmailAuthProvider.getCredential(
        email: firebaseUser.email, password: password);
    print("step 2");
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print("burda!!");
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = await _auth.currentUser();
    firebaseUser.updatePassword(password);
  }

  Future<void> _saveNewPasswordStep2(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(email);
    if (prefs != null) {
      var token = prefs.getString('user_token');
      print("usertoken -> " + token);
      if (await UserService.updatePassword(
              _currentPassword, _newPassword, token, email) !=
          null) {
        print("password değişti");
        updatePassword(_newPassword);
      }
    } else {
      print("local storage null veri yok !");
    }
  }
}
