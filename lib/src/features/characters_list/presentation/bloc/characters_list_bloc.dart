import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/domain/entities/character.dart';
import '../../../../core/domain/entities/page_info.dart';
import '../../domain/usecases/get_characters.dart';

part 'characters_list_event.dart';
part 'characters_list_state.dart';

@injectable
class CharactersListBloc
    extends Bloc<CharactersListEvent, CharactersListState> {
  final GetCharacters getCharacters;

  CharactersListBloc(
    this.getCharacters,
  ) : super(CharactersListState.initial()) {
    registerEvents();
  }

  void registerEvents() {
    on<LoadEvent>(_onLoadEvent);
    on<LoadMoreEvent>(
      _onLoadMoreEvent,
      transformer: debounce(
        const Duration(milliseconds: 100),
      ),
    );
  }

  EventTransformer<CharactersListEvent> debounce<CharactersListEvent>(
    Duration duration,
  ) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);

  FutureOr<void> _onLoadEvent(
    LoadEvent event,
    Emitter<CharactersListState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    final pageOrFailure = await getCharacters(event.page);
    emit(
      pageOrFailure.fold(
        (failure) => CharactersListState(
          info: null,
          characters: const [],
          errorMessage: failure.message,
          status: Status.error,
        ),
        (page) {
          return CharactersListState(
            status: Status.loaded,
            characters: [...state.characters, ...page.characters],
            info: page.info,
          );
        },
      ),
    );
  }

  FutureOr<void> _onLoadMoreEvent(
    LoadMoreEvent event,
    Emitter<CharactersListState> emit,
  ) async {
    if (hasNextPage()) {
      // hasHasNextPage() checks if state.info is null so we dont need to check for null again
      final nextPage = extractNextPageFromUrl(state.info!.next!);
      add(
        LoadEvent(nextPage),
      );
    }
  }

  @visibleForTesting
  int extractNextPageFromUrl(String url) {
    final page = url.split('page=')[1];
    return int.parse(page);
  }

  @visibleForTesting
  bool hasNextPage() {
    return state.info != null && state.info!.next != null;
  }
}
