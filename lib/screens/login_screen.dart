import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/models/django_user.dart';
import 'package:story/screens/signup_screen.dart';
import 'package:story/services/auth_service.dart';
import 'package:story/shared/loading.dart';
import 'package:story/services/shared_service.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _userToken;
  DjangoUser djangoUser;

  bool loading = false;

  String error = '';

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() => loading = true);
      if (await AuthService.loginAPI(context, _email, _password) != null) {
        djangoUser = await AuthService.loginAPI(context, _email, _password);

        //print({localStorage.get('user_token')});
        //print(SharedPreferences.getInstance());
        //SharedPreferences.setMockInitialValues({});
        SharedPreferences prefs = await SharedPreferences.getInstance();
        saveLogin(djangoUser.auth_token, djangoUser.id, prefs);
        if (prefs != null) {
          var token = prefs.getString('user_token');
          var token2 = prefs.getInt('user_id');
          print(token);
          print(token2);
          print("local storage not null veri var içinde!");
        } else {
          print("local storage null veri yok !");
        }

        print("django user geldi!!" + djangoUser.auth_token);
      } else {
        print("kullanıcı giremedi");
      }

      if (await AuthService.login(context, _email, _password) != null) {
        print("Succesfully logged in");
      } else {
        setState(() {
          error = 'Email or password wrong!!';
          loading = false;
        });
      }
    } else {
      print("buraya nerdem geldim");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/loginPhoto.png",
                    height: size.height * 0.20,
                  ),
                  Text(
                    'Evde Bahce',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Billabong',
                    ),
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 0.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.mail), labelText: 'Email'),
                            validator: (input) => !input.contains('@')
                                ? 'Email validation error!!'
                                : null,
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 0.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock_open),
                                suffixIcon: Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                labelText: 'Password'),
                            validator: (input) => input.length < 6
                                ? 'Password must be at least 6 characters'
                                : null,
                            onSaved: (input) => _password = input,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: 180.0,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black)),
                            onPressed: _submit,
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Don’t have an Account ? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, SignupScreen.id);
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class LoadingOptionClass {
  final String loadingOption1;

  LoadingOptionClass(this.loadingOption1);
}

saveLogin(userToken, userID, prefs) async {
  //await LoginScreen.init();
  //localStorage.setBool('is_login', true);
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //localStorage.setString('user_token', userToken);
  prefs.setString('user_token', userToken);
  prefs.setInt('user_id', userID);
}
