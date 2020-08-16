import 'package:flutter/material.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/services/auth_service.dart';
import 'package:story/shared/loading.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  static final String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name, _email, _password;
  bool loading = false;
  String error = '';

  Future<void> _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_name);
      print(_email);
      print(_password);
      print("ilk asama gecildi!");
      setState(() => loading = true);
      print("ikinci asama gecildi!");
      if (await AuthService.signUpUser(context, _name, _email, _password) !=
          null) {
        print("burdayım 111");
        Navigator.pop(context);
      } else {
        print("burdayım 222");
        setState(() {
          error = 'Email already using !!';
          loading = false;
          setState(() {});
        });
      }
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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
                                icon: Icon(Icons.person_add),
                                labelText: 'User Name'),
                            validator: (input) =>
                                input.trim().isEmpty || input.contains(' ')
                                    ? 'Please enter valid name!!'
                                    : null,
                            onSaved: (input) => _name = input,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 0.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.email), labelText: 'Email'),
                            validator: (input) => !input.contains('@') ||
                                    input.contains(' ') ||
                                    !input.contains('\.')
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
                                labelText: 'Password'),
                            validator: (input) =>
                                input.length < 6 || input.contains(' ')
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
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.black)),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Sign-Up',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an Account ? ",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        /*Container(
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
                        ),*/
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
