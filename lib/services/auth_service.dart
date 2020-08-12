import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story/models/user_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/shared/loading.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:story/screens/login_screen.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        /*AlertDialog(
          title: Text("welcome to EvdeBahce"),
          content: Text("Succesfully logged in "),
        );*/

        _firestore.collection('/users').document(signedInUser.uid).setData({
          'name': name,
          'email': email,
          'profileImageUrl': '',
        });
        print("bundan sonra 1");
        print(signedInUser.uid);
        //Provider.of<UserData>(context).currentUserId = signedInUser.uid;
        print("bundan sonra 2");
        Navigator.pop(context);
        print("bundan sonra 3");
      }
    } catch (e) {
      print('hata burda' + e);
      /*AlertDialog(
        title: Text("Failed "),
        content: Text("there is an error " + e),
      );*/
    }
  }

  static void logout() {
    _auth.signOut();
  }

  static void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }
}
