import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users/features/search/domain/usecase/get_automatically_suggestion_use_case.dart';
import 'package:users/features/search/domain/usecase/get_dropoff_location_use_case.dart';
import 'package:users/features/search/presentation/bloc/search_event.dart';
import 'package:users/features/search/presentation/bloc/search_state.dart';
import 'package:uuid/uuid.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetAutomaticallySuggestionUseCase getAutomaticallySuggestionUseCase;
  final GetDropoffLocationUseCase getDropoffLocationUseCase;
  String? sessionToken;
  int suggestCallCount = 0; // Track number of calls

  SearchBloc({
    required this.getAutomaticallySuggestionUseCase,
    required this.getDropoffLocationUseCase,
  }) : super(SearchInitialState()) {
    on<GetAutomaticallySuggestionEvent>(_onGetAutomaticallySuggestion);
    on<GetDropoffLocationEvent>(_onGetDropoffLocation);
  }

  Future<void> _onGetAutomaticallySuggestion(
      GetAutomaticallySuggestionEvent event, Emitter<SearchState> emit) async {
    emit(GetAutomaticallySuggestionLoadingState());

    // Generate a new session token only if it's null (new session)
    sessionToken ??= const Uuid().v4();

    // Reset sessionToken if the call count reaches 50
    if (suggestCallCount >= 50) {
      sessionToken = const Uuid().v4();
      suggestCallCount = 0; // Reset counter
    }

    suggestCallCount++; // Increment counter

    try {
      final suggestionPlaces = await getAutomaticallySuggestionUseCase.call(
        query: event.query,
        longitude: event.longitude,
        latitude: event.latitude,
        sessionToken: sessionToken!,
      );
      emit(GetAutomaticallySuggestionLoadedState(
          suggestionPlaces: suggestionPlaces));
    } catch (e) {
      emit(GetAutomaticallySuggestionErrorState(
          message: 'Fail to get suggestion places'));
    }
  }

  Future<void> _onGetDropoffLocation(
      GetDropoffLocationEvent event, Emitter<SearchState> emit) async {
    emit(GetDropoffLocationLoadingState());
    try {
      final dropoffLocation = await getDropoffLocationUseCase.call(
        mapboxId: event.mapboxId,
        sessionToken: event.sessionToken,
      );
      emit(GetDropoffLocationLoadedState(dropoffLocation: dropoffLocation));
      sessionToken = null;
    } catch (e) {
      emit(GetDropoffLocationErrorState(
          message: 'Fail to load drop off location'));
    }
  }
}
