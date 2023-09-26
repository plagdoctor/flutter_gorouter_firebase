import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io' show Platform;

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> emailSignUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> githubSignin() async {
    final GithubAuthProvider githubProvider = GithubAuthProvider();

    try {
      if (kIsWeb) {
        await _firebaseAuth.signInWithPopup(githubProvider);
      } else if (Platform.isAndroid || Platform.isIOS) {
        await _firebaseAuth.signInWithRedirect(githubProvider);
        await _firebaseAuth.getRedirectResult();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authStateStream = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
