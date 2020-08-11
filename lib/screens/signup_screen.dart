import 'package:flutter/material.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  static final String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_name);
      print(_email);
      print(_password);
      AuthService.signUpUser(context, _name, _email, _password);
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
                      decoration: InputDecoration(labelText: 'User Name'),
                      validator: (input) => input.trim().isEmpty
                          ? 'Please enter valid name!!'
                          : null,
                      onSaved: (input) => _name = input,
                    ),
                  ),
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
                        'Sign-Up',
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
                      onPressed: () => Navigator.pop(context),
                      color: Colors.green,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Back to Sign-in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
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
