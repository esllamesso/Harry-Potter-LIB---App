import 'package:book_app/core/utils/colors_manager.dart';
import 'package:book_app/core/utils/favorite_manager.dart';
import 'package:book_app/presentation/screens/fav_page.dart';
import 'package:book_app/presentation/widgets/shared/button_widget.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatefulWidget {
  final String fullName;
  final String nickname;
  final String hogwartsHouse;
  final String image;
  final String birthdate;

  const CharacterDetails({
    super.key,
    required this.fullName,
    required this.nickname,
    required this.hogwartsHouse,
    required this.image,
    required this.birthdate,
  });

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = FavoriteManager.isFavorite(widget.fullName);
  }

  void _toggleFavorite() {
    setState(() {
      final book = {
        "fullName": widget.fullName,
        "nickname": widget.nickname,
        "hogwartsHouse": widget.hogwartsHouse,
        "birthdate": widget.birthdate,
        "image": widget.image,
      };
      FavoriteManager.toggleFavorite(book);
      isFavorite = FavoriteManager.isFavorite(widget.fullName);
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
        title: const Text("Characters", style: TextStyle(fontWeight: FontWeight.w400)),
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
                widget.fullName,
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
                          widget.image,
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
                              "nickname: ${widget.nickname}",
                              style: TextStyle(
                                fontSize: width * 0.032,
                                color: ColorsManager.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "hogwartsHouse : ${widget.hogwartsHouse}",
                              style: TextStyle(
                                fontSize: width * 0.032,
                                color: ColorsManager.black,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "birthdate : ${widget.birthdate}",
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
                "children:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
