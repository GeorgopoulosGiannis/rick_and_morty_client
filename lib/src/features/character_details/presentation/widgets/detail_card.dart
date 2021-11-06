import 'package:flutter/material.dart';

import '../../../../core/domain/entities/character.dart';

import 'detail_image.dart';
import 'detail_field.dart';

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
