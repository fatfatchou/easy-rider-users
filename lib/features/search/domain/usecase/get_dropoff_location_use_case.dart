import 'package:users/features/home/domain/entities/location_entity.dart';
import 'package:users/features/search/domain/repositories/search_repository.dart';

class GetDropoffLocationUseCase {
  final SearchRepository searchRepository;

  GetDropoffLocationUseCase({required this.searchRepository});

  Future<LocationEntity> call({
    required mapboxId,
    required sessionToken,
  }) {
    return searchRepository.getDropoffLocation(
      mapboxId: mapboxId,
      sessionToken: sessionToken,
    );
  }
}
