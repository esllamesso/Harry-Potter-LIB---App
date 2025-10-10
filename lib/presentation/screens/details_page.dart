import 'package:book_app/core/utils/colors_manager.dart';
import 'package:book_app/core/utils/favorite_manager.dart';
import 'package:book_app/presentation/screens/fav_page.dart';
import 'package:book_app/presentation/widgets/shared/button_widget.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final String title;
  final String originalTitle;
  final String releaseDate;
  final int pages;
  final String description;
  final String cover;

  const DetailsPage({
    super.key,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.pages,
    required this.description,
    required this.cover,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteManager.isFavorite(widget.title);
  }

  void _toggleFavorite() {
    setState(() {
      final book = {
        "title": widget.title,
        "originalTitle": widget.originalTitle,
        "releaseDate": widget.releaseDate,
        "pages": widget.pages,
        "description": widget.description,
        "cover": widget.cover,
      };
      FavoriteManager.toggleFavorite(book);
      isFavorite = FavoriteManager.isFavorite(widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Book", style: TextStyle(fontWeight: FontWeight.w400)),
        backgroundColor: ColorsManager.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: ColorsManager.black,
                ),
              ),
              SizedBox(height: height * 0.01),
              Card(
                elevation: 0.2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.cover,
                          height: height * 0.25,
                          width: width * 0.35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Original Title : ${widget.originalTitle}",
                              style: TextStyle(
                                fontSize: width * 0.032,
                                color: ColorsManager.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "Release Date : ${widget.releaseDate}",
                              style: TextStyle(
                                fontSize: width * 0.032,
                                color: ColorsManager.black,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "Pages : ${widget.pages}",
                              style: TextStyle(
                                fontSize: width * 0.032,
                                color: ColorsManager.black,
                              ),
                            ),
                            SizedBox(height: height * 0.03),
                            ButtonWidget(
                              height: height * 0.05,
                              width: double.infinity,
                              text: isFavorite
                                  ? "Remove from Favourite"
                                  : "Add To Favourite",
                              color: ColorsManager.white,
                              onTap: _toggleFavorite,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                "Description:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                widget.description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
