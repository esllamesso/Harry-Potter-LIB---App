import 'package:book_app/logic/all_books/all_books_bloc.dart';
import 'package:book_app/logic/all_books/all_books_event.dart';
import 'package:book_app/logic/random_book/random_book_bloc.dart';
import 'package:book_app/logic/random_book/random_book_event.dart';
import 'package:book_app/logic/top_books/top_books_bloc.dart';
import 'package:book_app/logic/top_books/top_books_event.dart';
import 'package:book_app/presentation/screens/fav_page.dart';
import 'package:book_app/presentation/screens/search_screen.dart';
import 'package:book_app/presentation/screens/all_books_screen.dart';
import 'package:book_app/presentation/widgets/shared/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_app/core/utils/colors_manager.dart';
import 'package:book_app/presentation/widgets/book_sections/all_books.dart';
import 'package:book_app/presentation/widgets/book_sections/random_book.dart';
import 'package:book_app/presentation/widgets/book_sections/top_books.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllBooksBloc()..add(FetchAllBooksEvent()),
        ),
        BlocProvider(
          create: (context) => TopBooksBloc()..add(FetchTopBooksEvent()),
        ),
        BlocProvider(
          create: (context) => RandomBookBloc()..add(FetchRandomBook()),
        ),
      ],
      child: Builder(
        builder: (context) {
          // هنا استخدمنا Builder عشان يكون context داخل الـ MultiBlocProvider
          final pages = [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RandomBook(),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "All Books",
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<AllBooksBloc>(),
                                  child: const AllBooksScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'See More',
                            style: TextStyle(color: ColorsManager.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),
                    BooksList(),
                    SizedBox(height: height * 0.03),
                    Text(
                      "Top 3 Books",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.black,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    TopBooks(),
                  ],
                ),
              ),
            ),
            const FavPage(showAppBar: false),
            const SearchScreen(showAppBar: false),
          ];

          return Scaffold(
            backgroundColor: ColorsManager.white,
            appBar: currentIndex == 2
                ? null
                : AppBar(
              backgroundColor: ColorsManager.white,
              elevation: 0,
              title: Text(
                "Harry Potter Library!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05,
                  color: ColorsManager.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const SearchScreen(showAppBar: true),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search_sharp,
                    size: width * 0.07,
                    color: ColorsManager.black,
                  ),
                ),
              ],
            ),
            body: pages[currentIndex],
            extendBody: true,
            bottomNavigationBar: SimpleNavBar(
              currentIndex: currentIndex,
              onTap: (i) => setState(() => currentIndex = i),
            ),
          );
        },
      ),
    );
  }
}

