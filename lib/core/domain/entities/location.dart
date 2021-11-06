
import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String name;
  final String lastKnown;

  const Location({
    required this.name,
    required this.lastKnown,
  });

  @override
  List<Object?> get props => [
        name,
        lastKnown,
      ];
}