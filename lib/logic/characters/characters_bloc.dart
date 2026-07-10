import 'package:book_app/core/api/api_url.dart';
import 'package:book_app/data/character_model.dart';
import 'package:book_app/logic/characters/characters_event.dart';
import 'package:book_app/logic/characters/characters_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(CharactersInitial()) {
    on<FetchCharactersEvent>((event, emit) async {
      emit(CharactersLoading());

      try {
        final response = await Dio().get(ApiUrl.characters);

        final List data = response.data;

        final characters = data
            .map((json) => CharacterModel.fromJson(json))
            .toList();

        emit(CharactersSuccess(characters));
      } catch (e) {
        emit(CharactersError(e.toString()));
      }
    });
  }
}