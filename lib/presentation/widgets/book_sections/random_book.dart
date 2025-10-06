import 'package:book_app/logic/random_book/random_book_bloc.dart';
import 'package:book_app/logic/random_book/random_book_state.dart';
import 'package:book_app/presentation/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:book_app/core/utils/colors_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/skeletonizer.dart';

class RandomBook extends StatefulWidget {
  const RandomBook({super.key});

  @override
  State<RandomBook> createState() => _RandomBookState();
}

class _RandomBookState extends State<RandomBook> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.25,
      width: double.infinity,
      child: BlocBuilder<RandomBookBloc, RandomBookState>(
        builder: (context, state) {
          if (state is RandomBookLoading) {
            return Center(child: BooksListSkeleton());
          } else if (state is RandomBookSuccess) {
            final books = state.books;
            final book = books.isNotEmpty ? books[0] : null;
            if (book == null) return SizedBox.shrink();
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
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
              child: Card(
                elevation: 0.4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: height * 0.008,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            book.cover,
                            height: height * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                book.originalTitle,
                                style: TextStyle(
                                  color: ColorsManager.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.04,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: height * 0.01),
                              Text(
                                book.description,
                                style: TextStyle(
                                  fontSize: width * 0.032,
                                  color: ColorsManager.grey,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is RandomBookError) {
            return Text("Error : ${state.message}");
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
