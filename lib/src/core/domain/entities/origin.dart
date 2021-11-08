import 'package:equatable/equatable.dart';

class Origin extends Equatable {
  final String name;
  final String url;

  const Origin(
    this.name,
    this.url,
  );

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
