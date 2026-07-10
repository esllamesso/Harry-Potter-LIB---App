class ApiUrl {
  static const String baseUrl = "https://potterapi-fedeperin.vercel.app/en";

  static const String allBooks = "$baseUrl/books";

  static const String characters = "$baseUrl/characters";

  static const String houses = "$baseUrl/houses";

  static String bookByIndex(int index) => "$baseUrl?index=$index";

  static String topBooks(int max) => "$baseUrl?max=$max";

  static String searchBook(String query) => "$baseUrl?search=$query";

  static const String randomBook = "$baseUrl/books/random";
}
