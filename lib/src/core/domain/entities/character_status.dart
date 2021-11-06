

enum CharacterStatus {
  alive,
  dead,
  unknown,
}

extension TextProp on CharacterStatus {
  String get text {
    switch (this) {
      case CharacterStatus.alive:
        return 'Alive';
      case CharacterStatus.dead:
        return 'Dead';
      case CharacterStatus.unknown:
        return 'unknown';
      default:
        return 'unknown';
    }
  }
}
