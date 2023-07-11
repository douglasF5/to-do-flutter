import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth;
  Auth({required this.auth});

  // Get user info
  Stream<User?> get user => auth.authStateChanges();

  // Create user account
  Future<String> createAccount(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return 'Success!';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return 'Success!';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      rethrow;
    }
  }

  // Sing out
  Future<String> signOut() async {
    try {
      await auth.signOut();
      return 'Success!';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    } catch (e) {
      rethrow;
    }
  }
}
