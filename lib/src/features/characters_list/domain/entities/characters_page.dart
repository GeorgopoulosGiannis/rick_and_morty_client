import 'package:equatable/equatable.dart';

import '../../../../core/domain/entities/character.dart';
import '../../../../core/domain/entities/page_info.dart';

class CharactersPage extends Equatable {
  final PageInfo info;
  final List<Character> characters;

  const CharactersPage({
    required this.info,
    required this.characters,
  });

  @override
  List<Object?> get props => [
        info,
        characters,
      ];
}
