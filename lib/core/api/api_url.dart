class ApiUrl {

  static const String baseUrl = "https://potterapi-fedeperin.vercel.app/en/books";

  static const String allBooks = baseUrl;

  static String bookByIndex(int index) => "$baseUrl?index=$index";

  static String topBooks(int max) => "$baseUrl?max=$max";

  static String searchBook(String query) => "$baseUrl?search=$query";

  static const String randomBook = "$baseUrl/random";
  }

