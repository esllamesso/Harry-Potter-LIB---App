import 'package:book_app/core/api/api_url.dart';
import 'package:book_app/data/book_model.dart';

import 'package:book_app/logic/top_books/top_books_event.dart';
import 'package:book_app/logic/top_books/top_books_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBooksBloc extends Bloc<TopBooksEvent, TopBooksState> {
  TopBooksBloc() : super(TopBooksInitial()) {
    on<FetchTopBooksEvent>((event, emit) async {
      emit(TopBooksLoading());

      try {
        final response = await Dio().get(ApiUrl.topBooks(3));
        final List data = response.data;
        final books = data.map((json) => BookModel.fromJson(json)).toList();

        emit(TopBooksSuccess(books));
      } catch (e) {
        emit(TopBooksError(e.toString()));
      }
    });
  }
}
