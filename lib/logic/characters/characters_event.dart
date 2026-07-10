import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCharactersEvent extends CharactersEvent{}