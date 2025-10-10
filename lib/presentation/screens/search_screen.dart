import 'package:book_app/core/utils/colors_manager.dart';
import 'package:book_app/logic/search/search_bloc.dart';
import 'package:book_app/logic/search/search_event.dart';
import 'package:book_app/logic/search/search_state.dart';
import 'package:book_app/presentation/screens/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final bool? showAppBar;
  const SearchScreen({super.key, this.showAppBar});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: Builder(
        builder: (context) {
          final TextEditingController controller = TextEditingController();
          final width = MediaQuery.of(context).size.width;
          final height = MediaQuery.of(context).size.height;

          return Scaffold(
            backgroundColor: ColorsManager.white,
            appBar: showAppBar == true
                ? AppBar(
              backgroundColor: ColorsManager.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Search",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: width * 0.05,
                  color: ColorsManager.black,
                ),
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            )
                : null,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.02,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: controller,
                        onChanged: (value) {
                          context
                              .read<SearchBloc>()
                              .add(SearchBooksEvent(value.trim()));
                        },
                        decoration: InputDecoration(
                          hintText: "Search for a book...",
                          prefixIcon: const Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    Expanded(
                      child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is SearchLoaded) {
                            final books = state.results;
                            if (books.isEmpty) {
                              return const Center(
                                  child: Text("No results found"));
                            }

                            return ListView.separated(
                              itemCount: books.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: height * 0.015),
                              itemBuilder: (context, index) {
                                final book = books[index];
                                final title = book["title"] ?? "Unknown Title";
                                final cover = book["cover"] ??
                                    "https://via.placeholder.com/150";
                                final releaseDate =
                                    book["releaseDate"] ?? "Unknown";
                                final originalTitle =
                                    book["originalTitle"] ?? "";
                                final description =
                                    book["description"] ?? "";

                                return InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(
                                          title: title,
                                          originalTitle: originalTitle,
                                          releaseDate: releaseDate,
                                          pages: int.tryParse(book['pages']
                                              ?.toString() ??
                                              '0') ??
                                              0,
                                          description: description,
                                          cover: cover,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    color: ColorsManager.white,
                                    elevation: 0.5,
                                    shadowColor:
                                    Colors.black.withOpacity(0.05),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.025),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            child: Image.network(
                                              cover,
                                              height: height * 0.13,
                                              width: width * 0.23,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.04),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  title,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: width * 0.038,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                    height: height * 0.006),
                                                Text(
                                                  releaseDate,
                                                  style: TextStyle(
                                                    fontSize: width * 0.032,
                                                    color:
                                                    ColorsManager.grey,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height * 0.006),
                                                Text(
                                                  description,
                                                  style: TextStyle(
                                                    fontSize: width * 0.03,
                                                    color:
                                                    ColorsManager.grey,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (state is SearchError) {
                            return Center(child: Text(state.message));
                          }
                          return const Center(
                            child: Text("Type to search for a book..."),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
