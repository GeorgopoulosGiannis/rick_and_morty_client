import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

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
    
    
    add(const LoadEvent());
  }

  void registerEvents() {
    on<LoadEvent>(_onLoadEvent);
  }

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
        (page) => CharactersListState(
          status: Status.loaded,
          characters: page.characters,
          info: page.info,
        ),
      ),
    );
  }
}
