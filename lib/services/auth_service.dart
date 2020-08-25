import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story/models/django_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

        void userCreateHTTP(username, email, password) async {
          final response = await http
              .post('http://192.168.88.17:8000/api/auth/register', body: {
            "email": email,
            "first_name": username,
            "last_name": "",
            "password": password
          });
          if (response.statusCode == 200) {
            print("veri gönderildi");
          } else {
            print("veri burda!!");
            throw Exception('Failed to load stars');
          }
          print(response.body);
        }

        userCreateHTTP(name, email, password);

        print(signedInUser.uid);

        return 1;
      }
    } catch (e) {
      return null;
    }
  }

  static void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("log outdayız");
    if (prefs != null) {
      var token = prefs.getString('user_token');
      var token2 = prefs.getInt('user_id');
      print("log out daki token burda " + token);
      print("log outdayız local storage not null veri var içinde!");
    } else {
      print("local storage null veri yok !");
    }
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

  //static loginAPI(BuildContext context, String email, String password) async {
  static Future<DjangoUser> loginAPI(
      BuildContext context, String email, String password) async {
    try {
      print("LoginAPI fonksiyonu calısti");
      final response = await http.post(
          'http://192.168.88.17:8000/api/auth/login',
          body: {"email": email, "password": password});
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        DjangoUser djangoUser = new DjangoUser.fromJson(jsonData);
        print('auth_token print here ' + djangoUser.auth_token);

        return djangoUser;
      } else {
        print("veri burda!!");
        throw Exception('Failed to load user');
      }
      //print(response.body);
    } catch (e) {
      print("fonksiyon calıstı error buldu");
      return null;
    }
  }
}
