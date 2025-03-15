import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapboxMap? _mapboxController;

  void _onMapCreated(MapboxMap? controller) {
    setState(() {
      _mapboxController = controller;
    });

    _mapboxController?.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      onMapCreated: _onMapCreated,
    );
  }
}
