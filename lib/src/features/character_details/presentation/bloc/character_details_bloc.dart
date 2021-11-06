import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/character.dart';
import '../../domain/usecases/get_character.dart';

part 'character_details_event.dart';
part 'character_details_state.dart';

@injectable
class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final int? charID;
  final GetCharacter getChar;

  CharacterDetailsBloc(
    this.getChar, {
    @factoryParam this.charID,
  })  : assert(charID != null),
        super(Empty()) {
    registerEvents();
    add(LoadEvent());
  }

  void registerEvents() {
    on<LoadEvent>(_onLoadEvent);
  }

  FutureOr<void> _onLoadEvent(
    LoadEvent event,
    Emitter<CharacterDetailsState> emit,
  ) async {
    emit(Loading());
    final charOrFailure = await getChar(charID!);
    emit(
      charOrFailure.fold(
        (failure) => Error(failure.message),
        (char) => Loaded(char),
      ),
    );
  }
}
