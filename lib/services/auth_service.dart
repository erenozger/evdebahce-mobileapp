import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        print("id simdi basıyor");
        print(signedInUser.uid);
        print("id simdi basıyor");
        void userCreateHTTP(username, email, password) async {
          final response = await http
              .post('http://192.168.88.54:8000/api/register/', body: {
            "username": username,
            "email": email,
            "password": password
          });
          if (response.statusCode == 200) {
            print("veri gönderildi");
            final parsed = json.decode(response.body);
            print(parsed);
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
