import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:rick_and_morty_client/main.dart';
import 'package:rick_and_morty_client/src/core/injector.dart';
import 'package:rick_and_morty_client/src/core/router/route_generator.dart';
import 'package:wakelock/wakelock.dart';

void startApp() {
  runZonedGuarded(
    () {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      Wakelock.enable();
      configureDependencies();
      runApp(RickAndMortyClient(RouteGenerator()));
    },
    (Object error, StackTrace stacktrace) {
      if (!kReleaseMode) {
        // ignore: avoid_print
        print('error $error');
        // ignore: avoid_print
        print(stacktrace);
      }
    },
  );
}

void main() {
  group('end-to-end test', () {
    testWidgets(
        'Scroll list to get next page then zoom to see detail of character',
        (WidgetTester tester) async {
      startApp();

      await tester.pumpAndSettle();
      final listFinder = find.byKey(const Key('CharactersListKey'));

      final list = listFinder.evaluate().first.widget as ListView;

      expect(find.byKey(const Key('ListItemKey-1')), findsOneWidget);

      list.controller!.animateTo(
        list.controller!.position.maxScrollExtent - 200,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 100),
      );
      // await for LoadMoreEvent debounce and response
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final itemFinder = find.byKey(const Key('ListItemKey-20'),skipOffstage: false);
      
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.scrollUntilVisible(itemFinder, 300);

      // pump to make sure [Loader] mask is worn off
      await tester.pumpAndSettle();
      expect(itemFinder, findsOneWidget);

      // tap item and await to navigate to detail screen
      await tester.tap(itemFinder);

      // await detail screen to render
      await tester.pumpAndSettle();

      final detailScreenFinder = find.byKey(const Key('CharacterDetailsPage'));

      // check if new page is found
      expect(detailScreenFinder, findsOneWidget);

      // check if old page is gone
      expect(listFinder, findsNothing);
    });
  });
}
