import 'package:book_app/core/api/api_url.dart';
import 'package:book_app/data/book_model.dart';
import 'package:book_app/logic/random_book/random_book_event.dart';
import 'package:book_app/logic/random_book/random_book_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomBookBloc extends Bloc<RandomBookEvent, RandomBookState> {
  RandomBookBloc() : super(RandomBookInitial()) {
    on<FetchRandomBook>((event, emit) async {
      emit(RandomBookLoading());

      try {
        final response = await Dio().get(ApiUrl.randomBook);
        final data = response.data as Map<String, dynamic>;
        final book = BookModel.fromJson(data);
        emit(RandomBookSuccess([book]));

      } catch (e) {
        emit(RandomBookError(e.toString()));
      }
    });
  }
}
