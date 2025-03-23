import 'package:firebase_database/firebase_database.dart';
import 'package:users/core/global.dart';
import 'package:users/features/profile/data/models/user_model.dart';

class ProfileRemoteDataSource {

  Future<UserModel> getCurrentUser() async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(firebaseAuth.currentUser!.uid);

      DataSnapshot snapshot = await userRef.get();

      return UserModel.fromJson(snapshot);
    } catch (e) {
      rethrow;
    }
  }
}
