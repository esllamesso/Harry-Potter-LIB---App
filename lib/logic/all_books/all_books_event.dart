import 'package:equatable/equatable.dart';

abstract class AllBooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllBooksEvent extends AllBooksEvent{}