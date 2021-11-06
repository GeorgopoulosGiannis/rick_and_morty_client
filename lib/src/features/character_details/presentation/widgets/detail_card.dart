import 'package:flutter/material.dart';
import 'package:rick_and_morty_client/src/features/character_details/presentation/widgets/detail_field.dart';
import '../../../../core/domain/entities/character.dart';
import 'detail_image.dart';

class DetailCard extends StatelessWidget {
  final Character char;
  const DetailCard({
    Key? key,
    required this.char,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DetailImage(
          url: char.imageUrl,
        ),
        DetailField(
          title: 'Name',
          value: char.name,
        ),
        DetailField(
          title: 'Species',
          value: char.species,
        ),
        DetailField(
          title: 'Type',
          value: char.type,
        ),
        DetailField(
          title: 'Location',
          value: char.location.name,
        ),
      ],
    );
  }
}
