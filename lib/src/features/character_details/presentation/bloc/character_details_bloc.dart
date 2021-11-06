import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'character_details_event.dart';
part 'character_details_state.dart';

class CharacterDetailsBloc extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  CharacterDetailsBloc() : super(CharacterDetailsInitial()) {
    on<CharacterDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
