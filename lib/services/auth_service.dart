import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story/homescreen.dart';
import 'package:story/models/user_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:story/screens/login_screen.dart';
import 'package:story/shared/loading.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:story/screens/login_screen.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  //static void signUpUser
  static signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(email);
      print(password);
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'name': name,
          'email': email,
          'profileImageUrl': '',
        });

        print(signedInUser.uid);

        return 1;
      }
    } catch (e) {
      return null;
    }
  }

  static void logout() {
    _auth.signOut();
  }

  static login(BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return 1;
    } catch (e) {
      return null;
    }
  }
}
