import 'package:book_app/core/api/api_url.dart';
import 'package:book_app/data/book_model.dart';
import 'package:book_app/logic/all_books/all_books_event.dart';
import 'package:book_app/logic/all_books/all_books_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBooksBloc extends Bloc<AllBooksEvent, AllBooksState> {
  AllBooksBloc() : super(AllBooksInitial()) {
    on<FetchAllBooksEvent>((event, emit) async {
      emit(AllBooksLoading());

      try {
        final response = await Dio().get(ApiUrl.allBooks);
        final List data = response.data;
        final books = data.map((json) => BookModel.fromJson(json)).toList();

        emit(AllBooksSuccess(books));
      } catch (e) {
        emit(AllBooksError(e.toString()));
      }
    });
  }
}
