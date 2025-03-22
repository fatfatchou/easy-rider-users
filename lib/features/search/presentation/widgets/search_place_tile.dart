import 'package:flutter/material.dart';
import 'package:users/core/theme.dart';
import 'package:users/features/search/domain/entities/suggestion_place_entity.dart';

class SearchPlaceTile extends StatefulWidget {
  final SuggestionPlaceEntity? searchPlace;

  const SearchPlaceTile({super.key, required this.searchPlace});

  @override
  State<SearchPlaceTile> createState() => _SearchPlaceTileState();
}

class _SearchPlaceTileState extends State<SearchPlaceTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.location_searching,
        color: AppColors.yellow700,
      ),
      title: Text(
        widget.searchPlace!.mainText,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 16, color: AppColors.contentTertiary, fontWeight: FontWeight.w500),
        maxLines: 1,
      ),
      subtitle: Text(
        widget.searchPlace!.subText,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12, color: AppColors.gray300, fontWeight: FontWeight.w400),
        maxLines: 1,
      ),
    );
  }
}
