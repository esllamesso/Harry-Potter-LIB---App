import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BooksListSkeleton extends StatelessWidget {
  const BooksListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: height * 0.02),
            child: Row(
              children: [
                Container(
                  width: width * 0.25,
                  height: height * 0.15,
                  color: Colors.grey[300],
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: height * 0.02,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: height * 0.01),
                      Container(
                        width: width * 0.5,
                        height: height * 0.02,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
