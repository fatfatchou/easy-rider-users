import 'package:users/features/home/domain/entities/direction_entity.dart';

class DirectionModel extends DirectionEntity {
  DirectionModel({
    required super.distance,
    required super.duration,
    required super.ePoints,
  });

  factory DirectionModel.fromJson(Map<String, dynamic> json) {
    return DirectionModel(
      distance: json['distance'],
      duration: json['duration'],
      ePoints: json['geometry'],
    );
  }
}
