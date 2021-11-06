import 'package:flutter/material.dart';

import '../../../../core/domain/entities/character_status.dart';

class CardTitle extends StatelessWidget {
  final String name;
  final String species;
  final CharacterStatus status;
  const CardTitle({
    Key? key,
    required this.name,
    required this.species,
    required this.status,
  }) : super(key: key);

  Color _getBadgeColor() {
    switch (status) {
      case CharacterStatus.alive:
        return Colors.green;

      case CharacterStatus.dead:
        return Colors.red;
      case CharacterStatus.unknown:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: _getBadgeColor(),
              radius: 5,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${status.text} - $species',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        )
      ],
    );
  }
}
