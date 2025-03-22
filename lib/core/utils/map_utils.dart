import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

Position getCenterCoordinatesForPolyline({required List<Point> points}) {
  int pos = (points.length / 2).round();
  return Position(points[pos].coordinates.lng, points[pos].coordinates.lat);
}