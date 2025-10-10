import 'package:book_app/logic/all_books/all_books_bloc.dart';
import 'package:book_app/logic/all_books/all_books_state.dart';
import 'package:book_app/presentation/screens/details_page.dart';
import 'package:book_app/presentation/widgets/shared/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_app/core/utils/colors_manager.dart';

class AllBooksScreen extends StatelessWidget {
  const AllBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: context.read<AllBooksBloc>(),
      child: Scaffold(
        backgroundColor: ColorsManager.white,
        appBar: AppBar(
          title: const Text('All Books'),
          backgroundColor: ColorsManager.white,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: BlocBuilder<AllBooksBloc, AllBooksState>(
            builder: (context, state) {
              if (state is AllBooksLoading) {
                return Center(child: BooksListSkeleton());
              } else if (state is AllBooksSuccess) {
                final books = state.books;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: height * 0.02,
                    crossAxisSpacing: width * 0.03,
                    childAspectRatio: 0.55,
                  ),
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
                          padding: EdgeInsets.all(width * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  book.cover,
                                  height: height * 0.25,
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
                    );
                  },
                );
              } else if (state is AllBooksError) {
                return Center(child: Text("Error : ${state.massage}"));
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );

  }
}
