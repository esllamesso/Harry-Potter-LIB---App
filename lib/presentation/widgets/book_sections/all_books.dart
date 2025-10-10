import 'package:book_app/core/utils/colors_manager.dart';
import 'package:book_app/logic/all_books/all_books_bloc.dart';
import 'package:book_app/logic/all_books/all_books_state.dart';
import 'package:book_app/presentation/screens/details_page.dart';
import 'package:book_app/presentation/widgets/shared/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BooksList extends StatefulWidget {
  const BooksList({super.key});

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.40,
      child: BlocBuilder<AllBooksBloc, AllBooksState>(
        builder: (context, state) {
          if (state is AllBooksLoading) {
            return Center(child: BooksListSkeleton());
          } else if (state is AllBooksSuccess) {
            final books = state.books;
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: width * 0.03),
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
                  child: Container(
                    width: width * 0.45,
                    child: Card(
                      elevation: 0.2,
                      color: ColorsManager.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: AspectRatio(
                                aspectRatio: 0.7,
                                child: Image.network(
                                  book.cover,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.008),
                            Flexible(
                              child: Text(
                                book.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.035,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: height * 0.005),
                            Text(
                              book.releaseDate ?? "Unknown",
                              style: TextStyle(
                                fontSize: width * 0.03,
                                color: ColorsManager.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is AllBooksError) {
            return Center(child: Text("Error : ${state.massage}"));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
