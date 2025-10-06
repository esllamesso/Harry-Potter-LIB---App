import 'package:book_app/core/utils/colors_manager.dart';
import 'package:book_app/presentation/screens/home_page.dart';
import 'package:book_app/presentation/widgets/shared/button_widget.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                "assets/images/books.png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                left: 140,
                bottom: -25,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 136,
                  height: 136,
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              "Step into the magical world of Harry Potter at Hogwarts. "
                  "Explore spells, adventures, and mysteries from anywhere, "
                  "and discover your favorite wizarding tales. Enjoy your journey!"
              ,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          ButtonWidget(
            width: 350,
            text: "Get Started",
            color: ColorsManager.white,
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "Register",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
