import 'package:book_app/data/book_model.dart';
import 'package:equatable/equatable.dart';

abstract class RandomBookState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class RandomBookInitial extends RandomBookState{}
class RandomBookLoading extends RandomBookState{}
class RandomBookSuccess extends RandomBookState{
  final List<BookModel> books;

  RandomBookSuccess(this.books);

  @override
  List<Object?> get props => [books];
}
class RandomBookError extends RandomBookState{
  final String message;

  RandomBookError(this.message);

  @override
  List<Object?> get props => [message];
}