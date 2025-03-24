import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:users/core/global.dart';

class AuthRemoteDataSource {
  final String baseUrl;

  AuthRemoteDataSource({required this.baseUrl});

  User? currentUser;

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (auth) async {
          currentUser = auth.user;
          if (currentUser != null) {
            DatabaseReference userRef =
                FirebaseDatabase.instance.ref().child("users");
            userRef.child(currentUser!.uid).set({
              'id': currentUser!.uid,
              'name': name,
              'email': email,
              "phone": phone,
            });
          }
        },
      );
    } catch (e) {
      print('Error sign up: $e');
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child("users");

      DataSnapshot snapshot = await userRef.child(auth.user!.uid).get();

      if (snapshot.value == null) {
        firebaseAuth.signOut();
        throw Exception("User not found in database");
      }
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error reset password: $e');
      rethrow;
    }
  }
}
