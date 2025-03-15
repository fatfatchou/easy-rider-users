import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  mp.MapboxMap? _mapboxController;

  StreamSubscription? userPositionStream;

  @override
  void initState() {
    _setupPositionTracking();
    super.initState();
  }

  @override
  void dispose() {
    _mapboxController?.dispose();
    userPositionStream?.cancel();
    super.dispose();
  }

  void _onMapCreated(mp.MapboxMap? controller) {
    setState(() {
      _mapboxController = controller;
    });

    _mapboxController?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true, ),
    );
    
  }

  Future<void> _setupPositionTracking() async {
    bool isServiceEnabled;
    gl.LocationPermission permission;

    isServiceEnabled = await gl.Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error('Location services are disable');
    }

    permission = await gl.Geolocator.checkPermission();
    if (permission == gl.LocationPermission.denied) {
      permission = await gl.Geolocator.requestPermission();
      if (permission == gl.LocationPermission.denied) {
        return Future.error('Location services are disable');
      }
    }

    if (permission == gl.LocationPermission.deniedForever) {
      return Future.error(
          'Please turn the location permission on in the app setting');
    }

    gl.LocationSettings locationSettings = const gl.LocationSettings(
        accuracy: gl.LocationAccuracy.high, distanceFilter: 100);

    userPositionStream?.cancel();
    userPositionStream =
        gl.Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((gl.Position? position) {
      if (position != null && _mapboxController != null) {
        _mapboxController?.setCamera(
          mp.CameraOptions(
            zoom: 15,
            center: mp.Point(
              coordinates: mp.Position(position.longitude, position.latitude),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return mp.MapWidget(
      onMapCreated: _onMapCreated,
    );
  }
}
