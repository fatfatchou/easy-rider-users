import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/search/presentation/bloc/search_bloc.dart';
import 'package:users/features/search/presentation/bloc/search_event.dart';
import 'package:users/features/search/presentation/bloc/search_state.dart';
import 'package:users/features/search/presentation/widgets/progress_dialog.dart';
import 'package:users/features/search/presentation/widgets/search_place_tile.dart';

class SearchPlacesPage extends StatefulWidget {
  final double longitude;
  final double latitude;

  const SearchPlacesPage(
      {super.key, required this.longitude, required this.latitude});

  @override
  State<SearchPlacesPage> createState() => _SearchPlacesPageState();
}

class _SearchPlacesPageState extends State<SearchPlacesPage> {
  @override
  Widget build(BuildContext context) {
    bool darkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is GetDropoffLocationLoadingState) {
          // Show Loading Dialog
          showDialog(
              context: context,
              barrierDismissible:
                  false, // Prevent user from closing dialog manually
              builder: (context) => const ProgressDialog(
                  message: "Setting up Drop off location..."));
        } else if (state is GetDropoffLocationLoadedState) {
          // Close Dialog & Pop with Data
          Navigator.pop(context); // Close loading dialog
          Navigator.pop(
            context,
            state.dropoffLocation,
          ); // Pop to home with data
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.arrow_back_ios_new,
                      color: AppColors.contentPrimary),
                  SizedBox(width: 5),
                  Text(
                    "Back",
                    style: TextStyle(
                      color: AppColors.contentSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          leadingWidth: 100,
          backgroundColor: darkTheme ? Colors.black : Colors.white,
          surfaceTintColor: darkTheme ? Colors.black : Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.adjust_sharp,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 18.0),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextField(
                            onChanged: (query) {
                              if (query.length > 1) {
                                BlocProvider.of<SearchBloc>(context).add(
                                  GetAutomaticallySuggestionEvent(
                                    query: query,
                                    longitude: widget.longitude,
                                    latitude: widget.latitude,
                                  ),
                                );
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Search location...",
                              fillColor: AppColors.gray50,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 11,
                                top: 8,
                                bottom: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is GetAutomaticallySuggestionLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                } else if (state is GetAutomaticallySuggestionLoadedState) {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        height: 0,
                        color: AppColors.gray100,
                        thickness: 0,
                        indent: 55,
                      ),
                      itemCount: state.suggestionPlaces.length,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          BlocProvider.of<SearchBloc>(context).add(
                            GetDropoffLocationEvent(
                              mapboxId: state.suggestionPlaces[index].mapboxId,
                              sessionToken:
                                  state.suggestionPlaces[index].sessionToken,
                            ),
                          );
                        },
                        child: SearchPlaceTile(
                          searchPlace: state.suggestionPlaces[index],
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
