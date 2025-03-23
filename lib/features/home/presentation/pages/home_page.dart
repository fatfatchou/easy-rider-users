import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:users/core/theme.dart';
import 'package:users/core/utils/map_utils.dart';
import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/home/presentation/bloc/home_bloc.dart';
import 'package:users/features/home/presentation/bloc/home_event.dart';
import 'package:users/features/home/presentation/bloc/home_state.dart';
import 'package:users/features/search/presentation/pages/search_places_page.dart';
import 'package:users/features/search/presentation/widgets/progress_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  MapboxMap? _mapboxController;

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetUserLocationEvent());
    super.initState();
  }

  void _onMapCreated(MapboxMap? controller, HomeState? state) {
    setState(() {
      _mapboxController = controller;
    });
    _mapboxController?.location.updateSettings(
      LocationComponentSettings(enabled: true, pulsingEnabled: true),
    );

    if (state is HomeLoadedState && state.polylinePoints != null) {
      _addPolylineToMap(
        state.polylinePoints!
            .map((p) => [p.coordinates.lng, p.coordinates.lat])
            .toList(),
      );
    }

    if (state is HomeLoadedState && state.centerPoint != null) {
      // Add origin marker
      addMarkerToMap(
        _mapboxController!,
        state.location.longitude,
        state.location.latitude,
        "origin",
      );

      // Add dropoff marker
      addMarkerToMap(
        _mapboxController!,
        state.dropoffLocation!.longitude,
        state.dropoffLocation!.latitude,
        "dropoff",
      );

      _mapboxController!.location.updateSettings(
      LocationComponentSettings(enabled: false),
    );

      _mapboxController?.setCamera(
        CameraOptions(
          zoom: 15,
          center: Point(
            coordinates: Position(
              state.location.longitude,
              state.location.latitude,
            ),
          ),
        ),
      );

      _mapboxController?.flyTo(
        CameraOptions(
          zoom: 12,
          center: Point(
            coordinates: Position(
              state.centerPoint!.lng,
              state.centerPoint!.lat,
            ),
          ),
        ),
        MapAnimationOptions(
          duration: 500,
          startDelay: 1000,
        ),
      );
    } else if (state is HomeLoadedState && state.centerPoint == null) {
      _mapboxController?.setCamera(
        CameraOptions(
          zoom: 15,
          center: Point(
            coordinates: Position(
              state.location.longitude,
              state.location.latitude,
            ),
          ),
        ),
      );
    }
  }

  void _addPolylineToMap(List<List<num>> coordinates) async {
    if (_mapboxController == null || coordinates.isEmpty) return;

    // await _mapboxController?.style.removeStyleLayer('route-layer');
    // await _mapboxController?.style.removeStyleSource('route-source');

    // Convert GeoJSON object to a string
    String geoJsonData = jsonEncode({
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "geometry": {
            "type": "LineString",
            "properties": <String, dynamic>{},
            "coordinates": coordinates,
          },
        },
      ],
    });

    await _mapboxController!.style.addSource(GeoJsonSource(
      id: 'line',
      data: geoJsonData,
    ));

    await _mapboxController?.style.addLayer(LineLayer(
      id: 'route-layer',
      sourceId: 'line',
      lineColor: AppColors.yellow700.value,
      lineWidth: 5.0,
      lineCap: LineCap.ROUND
    ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build

    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            return current is HomeLoadedState &&
                current.dropoffLocation != null &&
                previous is HomeLoadedState &&
                previous.dropoffLocation != current.dropoffLocation;
          },
          listener: (context, state) {
            if (state is HomeLoadedState && state.dropoffLocation != null) {
              BlocProvider.of<HomeBloc>(context).add(
                GetPolylineEvent(
                  originLocation: state.location,
                  dropoffLocation: state.dropoffLocation!,
                ),
              );
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            return current is GetPolylineLoadingState ||
                previous is GetPolylineLoadingState;
          },
          listener: (context, state) {
            if (state is GetPolylineLoadingState) {
              showDialog(
                context: context,
                barrierDismissible:
                    false, // Prevent user from closing dialog manually
                builder: (context) =>
                    const ProgressDialog(message: "Please wait..."),
              );
            } else {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // Dismiss the dialo
            }
          },
        ),
        // BlocListener<HomeBloc, HomeState>(
        //   listenWhen: (previous, current) =>
        //       current is HomeLoadedState && current.polylinePoints != null,
        //   listener: (context, state) {
        //     if (state is HomeLoadedState &&
        //         state.polylinePoints != null &&
        //         _mapboxController != null) {
        //       print('REACH HERE');
        //       _addPolylineToMap(
        //         state.polylinePoints!
        //             .map((p) => [p.coordinates.lng, p.coordinates.lat])
        //             .toList(),
        //       );
        //     }
        //   },
        // ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is GetUserLocationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          } else if (state is HomeLoadedState) {
            // // Render polyline if available
            // if (state.polylinePoints != null &&
            //     state.polylinePoints!.isNotEmpty) {
            //   _addPolylineToMap(
            //     state.polylinePoints!
            //         .map((p) => [p.coordinates.lng, p.coordinates.lat])
            //         .toList(),
            //   );
            // }
            return Stack(
              children: [
                MapWidget(
                  onMapCreated: (controller) {
                    _onMapCreated(controller, state);
                  },
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
                          // Form Input Field
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

                          // To Input Field
                          GestureDetector(
                            onTap: () async {
                              final dropoffLocation = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPlacesPage(
                                    longitude: state.location.longitude,
                                    latitude: state.location.latitude,
                                  ),
                                ),
                              );

                              if (dropoffLocation != null &&
                                  dropoffLocation is LocationEntity &&
                                  mounted) {
                                BlocProvider.of<HomeBloc>(context).add(
                                  UpdateDropoffLocationEvent(
                                    dropoffLocation: dropoffLocation,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.gray100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: AppColors.red900),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "To",
                                            style: TextStyle(
                                              color: AppColors.contentPrimary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            state.dropoffLocation != null
                                                ? state.dropoffLocation!
                                                    .locationName
                                                : "Select a dropoff location...",
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
                          ),

                          // Continue Button
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
      ),
    );
  }
}
