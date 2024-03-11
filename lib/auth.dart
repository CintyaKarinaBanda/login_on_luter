// ignore_for_file: avoid_print, body_might_complete_normally_nullable
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:firebase_auth/firebase_auth.dart";

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  User ? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _firebaseAuth.currentUser;
    } catch (e) {
      print("Error en el inicio de sesión con correo y contraseña: $e");
      return null; 
    }
  }

  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredential.user;
      }
    } else {
      throw FirebaseAuthException(
        message: "Sign in aborded by user",
        code: "ERROR_ABORDER_BY_USER",
      );
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }


  Future<void> signOut() async {
    try {
      if (_firebaseAuth.currentUser != null) {
        // Sign out of Firebase
        await _firebaseAuth.signOut();

        // Sign out of Google (revoke access token)
        final googleSignIn = GoogleSignIn();
        await googleSignIn.signOut();
      }
    } catch (e) {
      print("Error signing out: $e");
      rethrow; // rethrow the exception after printing
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        print('Inicio de sesión con Facebook exitoso!');
        print('Token de acceso: ${result.accessToken!.token}');
      } else {
        print('Inicio de sesión con Facebook cancelado o fallido.');
      }
    } catch (e) {
      print('Error al iniciar sesión con Facebook: $e');
    }
  }



}