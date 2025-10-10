import 'package:book_app/core/utils/colors_manager.dart';
import 'package:book_app/core/utils/favorite_manager.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  final bool showAppBar;
  const FavPage({super.key, this.showAppBar = true});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteManager.favorites;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: widget.showAppBar
          ? AppBar(
        title: const Text("Favourites"),
        centerTitle: true,
        backgroundColor: ColorsManager.white,
      )
          : null,
      body: favorites.isEmpty
          ? const Center(child: Text("No favourites added yet"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final book = favorites[index];
          return ListTile(
            leading: Image.network(
              book['cover'],
              width: 50,
              fit: BoxFit.cover,
            ),
            title: Text(book['title']),
            subtitle: Text(book['releaseDate']),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                setState(() {
                  FavoriteManager.toggleFavorite(book);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
