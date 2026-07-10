import 'package:book_app/logic/all_books/all_books_bloc.dart';
import 'package:book_app/logic/all_books/all_books_event.dart';
import 'package:book_app/logic/characters/characters_bloc.dart';
import 'package:book_app/logic/characters/characters_event.dart';
import 'package:book_app/logic/random_book/random_book_bloc.dart';
import 'package:book_app/logic/random_book/random_book_event.dart';
import 'package:book_app/logic/top_books/top_books_bloc.dart';
import 'package:book_app/logic/top_books/top_books_event.dart';
import 'package:book_app/presentation/screens/fav_page.dart';
import 'package:book_app/presentation/screens/search_screen.dart';
import 'package:book_app/presentation/widgets/shared/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:book_app/core/utils/colors_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/category_tabs.dart';
import '../widgets/dynamic_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int selectedCategory = 2;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => CharactersBloc()..add(FetchCharactersEvent()),
        ),

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
          final pages = [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 10),

                    Text(
                      "Harry Potter",
                      style: TextStyle(
                        fontSize: width * .08,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Discover your favourite books",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: width * .04,
                      ),
                    ),

                    const SizedBox(height: 25),

                    CategoryTabs(
                      selectedIndex: selectedCategory,
                      onChanged: (index) {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                    ),

                    const SizedBox(height: 25),

                    Expanded(
                      child: DynamicList(
                        selectedIndex: selectedCategory,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const FavPage(showAppBar: false),
            const SearchScreen(showAppBar: false),
          ];

          return Scaffold(
            backgroundColor: Colors.white,

            appBar: currentIndex == 2
                ? null
                : AppBar(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Library",
              ),
              centerTitle: false,
              actions: [

                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const SearchScreen(showAppBar: true),
                          ),
                        );
                      },
                      icon: const Icon(Icons.search),
                    ),
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

