import 'package:book_app/logic/all_books/all_books_bloc.dart';
import 'package:book_app/logic/all_books/all_books_state.dart';
import 'package:book_app/presentation/widgets/shared/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_book_card.dart';

class BooksList extends StatelessWidget {
  const BooksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllBooksBloc, AllBooksState>(
      builder: (context, state) {
        if (state is AllBooksLoading) {
          return const Center(
            child: BooksListSkeleton(),
          );
        }

        if (state is AllBooksError) {
          return Center(
            child: Text(state.massage),
          );
        }

        if (state is AllBooksSuccess) {
          final books = state.books;

          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              return HomeBookCard(
                book: books[index],
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}