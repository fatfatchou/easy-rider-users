import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Position getCenterCoordinatesForPolyline({required List<Point> points}) {
  int pos = (points.length / 2).round();
  return Position(points[pos].coordinates.lng, points[pos].coordinates.lat);
}

Future<PointAnnotation> addMarkerToMap({
    required MapboxMap controller, required Point point, required String markerName, String? driverId}) async {
  final ByteData bytes = await rootBundle.load(markerName == "origin"
      ? 'assets/images/origin.png'
      : markerName == "dropoff"
          ? 'assets/images/dropoff.png'
          : 'assets/images/car.png');
  final Uint8List icon = bytes.buffer.asUint8List();

  return await controller.annotations.createPointAnnotationManager(id: driverId).then((manager) {
    print('Add a driver marker');
    return manager.create(
      PointAnnotationOptions(
        geometry: point,
        iconSize: 1.5, // Adjust marker size
        image: icon, // Make sure you have a custom marker in Mapbox style
        iconOffset: [0.0, -10.0],
      ),
    );
  });
}
