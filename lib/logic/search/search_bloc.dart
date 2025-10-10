import 'package:book_app/core/api/api_url.dart';
import 'package:book_app/logic/search/search_event.dart';
import 'package:book_app/logic/search/search_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchBooksEvent>((event, emit) async {
      final query = event.query.trim();

      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());

      try {
        final response = await Dio().get(ApiUrl.searchBook(query));

        final data = response.data;

        if (data is List) {
          emit(SearchLoaded(data));
        } else if (data is Map && data.containsKey('books')) {
          emit(SearchLoaded(List<Map<String, dynamic>>.from(data['books'])));
        } else {
          emit(SearchError("Unexpected data format"));
        }
      } catch (e) {
        emit(SearchError("Failed to fetch results: $e"));
      }
    });
  }
}
