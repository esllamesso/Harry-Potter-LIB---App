import 'package:book_app/logic/random_book/random_book_bloc.dart';
import 'package:book_app/logic/random_book/random_book_state.dart';
import 'package:book_app/presentation/widgets/shared/skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_book_card.dart';

class RandomBook extends StatelessWidget {
  const RandomBook({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomBookBloc, RandomBookState>(
      builder: (context, state) {
        if (state is RandomBookLoading) {
          return const Center(
            child: BooksListSkeleton(),
          );
        }

        if (state is RandomBookError) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is RandomBookSuccess) {
          if (state.books.isEmpty) {
            return const Center(
              child: Text("No Book Found"),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            physics: const BouncingScrollPhysics(),
            children: [
              HomeBookCard(
                book: state.books.first,
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}