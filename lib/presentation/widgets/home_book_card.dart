import 'package:book_app/presentation/screens/details_page.dart';
import 'package:flutter/material.dart';
import '../../data/book_model.dart';

class HomeBookCard extends StatelessWidget {
  final BookModel book;

  const HomeBookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              title: book.title,
              originalTitle: book.originalTitle,
              releaseDate: book.releaseDate,
              pages: book.pages,
              description: book.description,
              cover: book.cover,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: height * .025),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: book.number,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  bottomLeft: Radius.circular(28),
                ),
                child: Image.network(
                  book.cover,
                  width: width * .33,
                  height: height * .24,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(width * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.shade100,
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    ),

                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width * .05,
                      ),
                    ),

                    SizedBox(height: height * .008),

                    Text(
                      book.originalTitle,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: width * .037,
                      ),
                    ),

                    SizedBox(height: height * .02),

                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 6),
                        Text(book.releaseDate),
                      ],
                    ),

                    SizedBox(height: height * .012),

                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book,
                          size: 18,
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(width: 6),
                        Text("${book.pages} Pages"),
                      ],
                    ),

                    SizedBox(height: height * .025),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsPage(
                                    title: book.title,
                                    originalTitle: book.originalTitle,
                                    releaseDate: book.releaseDate,
                                    pages: book.pages,
                                    description: book.description,
                                    cover: book.cover,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Details"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}