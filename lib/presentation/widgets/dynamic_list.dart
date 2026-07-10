import 'package:book_app/presentation/widgets/book_sections/all_books.dart';
import 'package:book_app/presentation/widgets/book_sections/characters_list.dart';
import 'package:book_app/presentation/widgets/book_sections/random_book.dart';
import 'package:book_app/presentation/widgets/book_sections/top_books.dart';
import 'package:flutter/material.dart';

class DynamicList extends StatelessWidget {
  final int selectedIndex;

  const DynamicList({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    switch (selectedIndex) {
      case 0:
        return const SizedBox(
          key: ValueKey(0),
          child: CharactersList(),
        );

      case 1:
        return const SizedBox(
          key: ValueKey(1),
          child: RandomBook(),
        );

      case 2:
        return const SizedBox(
          key: ValueKey(2),
          child: BooksList(),
        );

      case 3:
        return const SizedBox(
          key: ValueKey(3),
          child: TopBooks(),
        );

      default:
        return const SizedBox(
          key: ValueKey(4),
          child: BooksList(),
        );
    }
  }
}