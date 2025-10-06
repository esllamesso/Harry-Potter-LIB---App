import 'package:book_app/core/utils/colors_manager.dart';
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
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Book", style: TextStyle(fontWeight: FontWeight.w400)),
        backgroundColor: ColorsManager.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            icon: Icon(
              isSelected ? Icons.favorite : Icons.favorite_border,
              color: isSelected ? Colors.red : Colors.black,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
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
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.04,
                    horizontal: height * 0,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.cover,
                            height: height * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Original Title : ${widget.originalTitle}",
                                style: TextStyle(
                                  color: ColorsManager.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.03,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: height * 0.01),

                              Text(
                                "Release Date : ${widget.releaseDate}",
                                style: TextStyle(
                                  color: ColorsManager.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: width * 0.03,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                "Pages : ${widget.pages}",
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.w500,
                                  color: ColorsManager.black,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: height * 0.03),

                              ButtonWidget(
                                height: height * 0.05,
                                width: double.infinity,
                                text: "Add To Favourite",
                                color: ColorsManager.white,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FavPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.01),

              Text(
                "Description:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.black,
                ),
              ),

              SizedBox(height: height * 0.02),

              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
