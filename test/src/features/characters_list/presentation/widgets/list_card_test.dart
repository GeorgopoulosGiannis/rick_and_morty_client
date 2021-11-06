import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_client/src/core/domain/entities/character.dart';
import 'package:rick_and_morty_client/src/core/domain/entities/character_status.dart';
import 'package:rick_and_morty_client/src/core/domain/entities/location.dart';
import 'package:rick_and_morty_client/src/core/domain/entities/origin.dart';
import 'package:rick_and_morty_client/src/features/characters_list/presentation/widgets/list_card.dart';

void main() {
  const char = Character(
    id: 1,
    name: 'tSame',
    status: CharacterStatus.alive,
    species: 'tSpecies',
    type: 'tType',
    gender: 'tGender',
    origin: Origin('tOriginName', 'tOriginLocation'),
    location: Location(name: 'tLocationName', lastKnown: 'tLastknown'),
    imageUrl: 'tImageUrl',
    episode: [],
    url: 'turl',
  );

  group(
    'List Card',
    () {
      testWidgets('Should display image', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: (context, widget) {
              return Material(
                child: ListCard(
                  char: char,
                  onTap: () {},
                ),
              );
            },
          ),
        );
        final imageFinder = find.byType(Image);
        expect(imageFinder, findsOneWidget);
      });

      testWidgets('Should display green badge if status is alive',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: (context, widget) {
              return Material(
                child: ListCard(
                  char: char,
                  onTap: () {},
                ),
              );
            },
          ),
        );
        final badgeFinder = find.byType(CircleAvatar);
        final avatar =badgeFinder.evaluate().single.widget as CircleAvatar;

        expect(badgeFinder, findsOneWidget);
        expect( avatar.backgroundColor,Colors.green);
      });
    },
  );
}
