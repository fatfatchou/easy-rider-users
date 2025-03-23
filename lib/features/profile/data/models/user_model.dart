import 'package:firebase_database/firebase_database.dart';
import 'package:users/features/profile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.phone,
  });

  factory UserModel.fromJson(DataSnapshot snap) {
    return UserModel(
      id: snap.key,
      name: (snap.value as dynamic)["name"],
      email: (snap.value as dynamic)["email"],
      phone: (snap.value as dynamic)["phone"],
    );
  }
}
