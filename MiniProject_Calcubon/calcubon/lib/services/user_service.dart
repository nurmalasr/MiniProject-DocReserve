import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

abstract class UserService {
  static Future<UserModel?> getUser({required String token}) async {
    final userCollection =
        await FirebaseFirestore.instance.collection('user').doc(token).get();

    return UserModel(
      token: token,
      fullname: userCollection.data()!['fullname'],
      tglLahir: userCollection.data()!['tglLahir'],
      location: userCollection.data()!['location'],
    );
  }

  static Future<String?> getToken(
      {required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.uid.isNotEmpty) {
        return userCredential.user!.uid;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-login-credentials":
          log("Kata sandi salah");
          break;
        default:
          log("error: ${e.code}");
      }
    }
    return null;
  }

  static Future<bool> isTokenValid() async {
    final userCredential = FirebaseAuth.instance.currentUser;
    if (userCredential!.uid.isNotEmpty) {
      return true;
    }
    return false;
  }

  static void editUser({
    required String token,
    required String fullname,
    required String tglLahir,
    required String location,
  }) {
    FirebaseFirestore.instance.collection('user').doc(token).update({
      'fullname': fullname,
      'tglLahir': tglLahir,
      'location': location,
    });
  }
}
