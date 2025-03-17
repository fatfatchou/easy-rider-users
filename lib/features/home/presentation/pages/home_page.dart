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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  mp.MapboxMap? _mapboxController;

  // StreamSubscription? userPositionStream;

  @override
  void initState() {
    // _setupPositionTracking();
    // context
    //     .read<HomeBloc>()
    //     .add(TrackUserLocationEvent()); // Start tracking when UI loads
    BlocProvider.of<HomeBloc>(context).add(GetUserLocationEvent());
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
    super.build(context); // Call super.build

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is GetUserLocationLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        } else if (state is GetUserLocationLoadedState) {
          _mapboxController?.setCamera(
            mp.CameraOptions(
              zoom: 15,
              center: mp.Point(
                coordinates: mp.Position(
                  state.location.longitude,
                  state.location.latitude,
                ),
              ),
            ),
          );
          return Stack(
            children: [
              mp.MapWidget(
                onMapCreated: _onMapCreated,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.gray100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: AppColors.primary900),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "From",
                                        style: TextStyle(
                                          color: AppColors.contentPrimary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        state.location.locationName,
                                        style: const TextStyle(
                                          color: AppColors.gray400,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.gray100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: AppColors.red900),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "To",
                                      style: TextStyle(
                                        color: AppColors.contentPrimary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "A35 Bach Dang...",
                                      style: TextStyle(
                                        color: AppColors.gray400,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is GetUserLocationErrorState) {
          return Center(child: Text(state.message));
        }
        return const Center();
      },
    );
  }
}
