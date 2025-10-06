import 'package:equatable/equatable.dart';

abstract class TopBooksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTopBooksEvent extends TopBooksEvent{}