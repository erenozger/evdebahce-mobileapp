import 'package:flutter/material.dart';
import 'package:story/data.dart';
import 'package:story/homescreen.dart';
import 'package:story/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:story/screens/story_screen.dart';
import 'package:story/services/auth_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_email);
      print(_password);
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );*/
      AuthService.login(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Evde Bahce',
              style: TextStyle(
                fontSize: 50.0,
                fontFamily: 'Billabong',
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (input) => !input.contains('@')
                          ? 'Email validation error!!'
                          : null,
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (input) => input.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                      onSaved: (input) => _password = input,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 180.0,
                    child: FlatButton(
                      onPressed: _submit,
                      color: Colors.green,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 180.0,
                    child: FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, SignupScreen.id),
                      color: Colors.green,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Go to Sign-up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 180.0,
                    child: IconButton(
                      icon: Icon(Icons.warning),
                      onPressed: () {
                        Alert(
                          context: context,
                          title: "Wrong!",
                          desc: "Wrong password or email",
                        ).show();
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StoryScreen(
                                    stories: stories,
                                  )),
                        );*/
                      },
                      color: Colors.green,
                      padding: EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
