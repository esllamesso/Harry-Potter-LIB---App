import 'package:book_app/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Favourite",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: width * 0.05,
            color: ColorsManager.black,
          ),
        ),
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_rounded)),
      ),
      backgroundColor: ColorsManager.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              textAlign: TextAlign.center,
              "Your favorite book will appear here, but the page has not been loaded yet.",
            ),
          ),
        ],
      ),
    );
  }
}
