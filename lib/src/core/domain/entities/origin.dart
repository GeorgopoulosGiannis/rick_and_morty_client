import 'package:equatable/equatable.dart';

class Origin extends Equatable {
  final String name;
  final String location;

  const Origin(
    this.name,
    this.location,
  );

  @override
  List<Object?> get props => [
        name,
        location,
      ];
}
