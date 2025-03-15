import 'package:firebase_database/firebase_database.dart';
import 'package:users/core/global.dart';
import 'package:users/features/splash/data/models/user_model.dart';

class SplashRemoteDataSource {
  final String baseUrl;

  SplashRemoteDataSource({required this.baseUrl});
  
  Future<UserModel> readCurrentOnlineUserInfo() async {
    try {
      currentUser = firebaseAuth.currentUser;
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(currentUser!.uid);

      DataSnapshot snapshot = await userRef.get();
      return UserModel.fromSnapshot(snapshot);
    } catch (e) {
      rethrow;
    }
  }
}
