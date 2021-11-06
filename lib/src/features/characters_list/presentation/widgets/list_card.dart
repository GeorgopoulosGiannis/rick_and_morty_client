import 'package:flutter/material.dart';

import '../../../../core/domain/entities/character.dart';
import 'cart_subtitle.dart';

import 'card_image.dart';
import 'card_title.dart';

class ListCard extends StatelessWidget {
  final Character char;
  const ListCard({
    Key? key,
    required this.char,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: CardImage(
                url: char.imageUrl,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CardTitle(
                    name: char.name,
                    species: char.species,
                    status: char.status,
                  ),
                  CardSubtitle(
                    lastKnown: char.location.name,
                    firstSeen: char.origin.name,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
