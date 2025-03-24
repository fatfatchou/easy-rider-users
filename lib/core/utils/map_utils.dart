import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Position getCenterCoordinatesForPolyline({required List<Point> points}) {
  int pos = (points.length / 2).round();
  return Position(points[pos].coordinates.lng, points[pos].coordinates.lat);
}

void addMarkerToMap(
    MapboxMap controller, Point point, String markerName) async {
  final ByteData bytes = await rootBundle.load(markerName == "origin"
      ? 'assets/images/origin.png'
      : 'assets/images/dropoff.png');
  final Uint8List icon = bytes.buffer.asUint8List();

  await controller.annotations.createPointAnnotationManager().then((manager) {
    manager.create(
      PointAnnotationOptions(
        geometry: point,
        iconSize: 1.5, // Adjust marker size
        image: icon, // Make sure you have a custom marker in Mapbox style
        iconOffset: [0.0, -10.0],
      ),
    );
  });
}
