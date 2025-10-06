import 'package:book_app/logic/top_books/top_books_bloc.dart';
import 'package:book_app/logic/top_books/top_books_state.dart';
import 'package:book_app/presentation/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colors_manager.dart';
import '../shared/skeletonizer.dart';

class TopBooks extends StatefulWidget {
  const TopBooks({super.key});

  @override
  State<TopBooks> createState() => _TopBooksState();
}

class _TopBooksState extends State<TopBooks> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.40,
      child: BlocBuilder<TopBooksBloc, TopBooksState>(
        builder: (context, state) {
          if (state is TopBooksLoading) {
            return Center(child: BooksListSkeleton());
          } else if (state is TopBooksSuccess) {
            final books = state.books;
            return ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  SizedBox(width: width * 0.03),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
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
                    elevation: 0.2,
                    color: ColorsManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: width * 0.45,
                      padding: EdgeInsets.all(width * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              book.cover,
                              height: height * 0.28,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: height * 0.008),
                          Text(
                            book.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            book.releaseDate,
                            style: TextStyle(
                              fontSize: width * 0.03,
                              color: ColorsManager.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TopBooksError) {
            return Text("Error : ${state.massage}");
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
