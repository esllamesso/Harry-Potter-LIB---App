class FavoriteManager {
  static final List<Map<String, dynamic>> favorites = [];

  static void toggleFavorite(Map<String, dynamic> book) {
    final existing = favorites.indexWhere((item) => item['title'] == book['title']);
    if (existing == -1) {
      favorites.add(book);
    } else {
      favorites.removeAt(existing);
    }
  }

  static bool isFavorite(String title) {
    return favorites.any((item) => item['title'] == title);
  }
}
