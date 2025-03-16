import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as gl;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mp;
import 'package:users/core/theme.dart';
import 'package:users/features/home/presentation/bloc/home_bloc.dart';
import 'package:users/features/home/presentation/bloc/home_event.dart';
import 'package:users/features/home/presentation/bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  mp.MapboxMap? _mapboxController;

  // StreamSubscription? userPositionStream;

  @override
  void initState() {
    // _setupPositionTracking();
    context
        .read<HomeBloc>()
        .add(TrackUserLocationEvent()); // Start tracking when UI loads
    super.initState();
  }

  // @override
  // void dispose() {
  //   _mapboxController?.dispose();
  //   userPositionStream?.cancel();
  //   super.dispose();
  // }

  void _onMapCreated(mp.MapboxMap? controller) {
    setState(() {
      _mapboxController = controller;
    });

    _mapboxController?.location.updateSettings(
      mp.LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );
  }

  // Future<void> _setupPositionTracking() async {
  //   bool isServiceEnabled;
  //   gl.LocationPermission permission;

  //   isServiceEnabled = await gl.Geolocator.isLocationServiceEnabled();

  //   if (!isServiceEnabled) {
  //     return Future.error('Location services are disable');
  //   }

  //   permission = await gl.Geolocator.checkPermission();
  //   if (permission == gl.LocationPermission.denied) {
  //     permission = await gl.Geolocator.requestPermission();
  //     if (permission == gl.LocationPermission.denied) {
  //       return Future.error('Location services are disable');
  //     }
  //   }

  //   if (permission == gl.LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Please turn the location permission on in the app setting');
  //   }

  //   gl.LocationSettings locationSettings = const gl.LocationSettings(
  //       accuracy: gl.LocationAccuracy.high, distanceFilter: 100);

  //   userPositionStream?.cancel();
  //   userPositionStream =
  //       gl.Geolocator.getPositionStream(locationSettings: locationSettings)
  //           .listen((gl.Position? position) {
  //     if (position != null && _mapboxController != null) {
  //       _mapboxController?.setCamera(
  //         mp.CameraOptions(
  //           zoom: 15,
  //           center: mp.Point(
  //             coordinates: mp.Position(position.longitude, position.latitude),
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is HomeLoadedState) {
          _mapboxController?.setCamera(
            mp.CameraOptions(
              zoom: 15,
              center: mp.Point(
                coordinates: mp.Position(
                    state.location.longitude, state.location.latitude),
              ),
            ),
          );
        } else if (state is HomeErrorState) {
          return Center(child: Text(state.message));
        }
        return mp.MapWidget(
          onMapCreated: _onMapCreated,
        );
      },
    );
  }
}
