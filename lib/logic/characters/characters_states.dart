import 'package:book_app/data/book_model.dart';
import 'package:book_app/data/character_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();

  @override
  List<Object?> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersSuccess extends CharactersState {
  final List<CharacterModel> characters;

  const CharactersSuccess(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharactersError extends CharactersState {
  final String massage;

  const CharactersError(this.massage);

  @override
  List<Object?> get props => [massage];
}
