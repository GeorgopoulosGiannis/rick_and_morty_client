import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rick_and_morty_client/src/features/characters_list/data/models/characters_page_model.dart';
import 'package:rick_and_morty_client/src/features/characters_list/presentation/bloc/characters_list_bloc.dart';
import 'package:rick_and_morty_client/src/features/characters_list/presentation/pages/characters_list_page.dart';

import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class FakeCharactersListEvent extends Fake implements CharactersListEvent {}

class FakeCharactersListState extends Fake implements CharactersListState {}

class MockCharactersListBloc
    extends MockBloc<CharactersListEvent, CharactersListState>
    implements CharactersListBloc {}

void main() {
  late CharactersListBloc mockBloc;
  final tCharacterPageResponse =
      CharactersPageModel.fromJson(json.decode(fixture('characters')));

  final loadedFirstPageState = CharactersListState(
    characters: tCharacterPageResponse.characters,
    info: tCharacterPageResponse.info,
    status: Status.loaded,
  );
  setUpAll(() {
    registerFallbackValue(FakeCharactersListEvent());
    registerFallbackValue(FakeCharactersListState());
  });

  setUp(() {
    mockBloc = MockCharactersListBloc();
  });
  testWidgets(
    'Should call loadMoreEvent on bloc when user scrolls to bottom',
    (WidgetTester tester) async {
      whenListen(
        mockBloc,
        Stream.fromIterable(
          [
            loadedFirstPageState,
            loadedFirstPageState.copyWith(status: Status.loading),
            loadedFirstPageState,
          ],
        ),
        initialState: loadedFirstPageState,
      );

      expect(mockBloc.state, loadedFirstPageState);

      await tester.pumpWidget(
        MaterialApp(
          builder: (_, __) => BlocProvider<CharactersListBloc>.value(
            value: mockBloc,
            child: const CharactersListPage(),
          ),
        ),
      );
      
      await tester.pumpAndSettle();
      final list = find
          .byKey(const Key('CharactersListKey'))
          .evaluate()
          .first
          .widget as ListView;

      list.controller!.animateTo(
        // 200 is scrollThreshold
        list.controller!.position.maxScrollExtent-200,
        curve: Curves.linear,
        duration: Duration(seconds: 1),
      );
      await tester.pumpAndSettle();
      
      verify(() => mockBloc.add(const LoadMoreEvent())).called(1);
    },
  );
}
