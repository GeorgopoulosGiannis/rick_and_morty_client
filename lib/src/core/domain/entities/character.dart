import 'package:equatable/equatable.dart';

import 'character_status.dart';
import 'location.dart';
import 'origin.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String imageUrl;
  final List<String> episode;
  final String url;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.imageUrl,
    required this.episode,
    required this.url,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        imageUrl,
        episode,
        url,
      ];
}
