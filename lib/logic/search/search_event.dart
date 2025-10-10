abstract class SearchEvent {}

class SearchBooksEvent extends SearchEvent {
  final String query;
  SearchBooksEvent(this.query);
}
