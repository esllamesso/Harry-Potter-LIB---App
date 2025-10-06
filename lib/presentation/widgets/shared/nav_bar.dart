import 'package:flutter/material.dart';
import 'package:book_app/core/utils/colors_manager.dart';

class SimpleNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const SimpleNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  Widget _buildItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = index == currentIndex;
    final double iconSize = MediaQuery.of(context).size.width * 0.065;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 4), // 👈 دي اللي بتنزل الأيقونة شوية لتحت
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  vertical: isSelected ? 4 : 2,
                  horizontal: isSelected ? 50 : 5,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? ColorsManager.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: isSelected ? ColorsManager.black : ColorsManager.white,
                ),
              ),

              const SizedBox(height: 4), // المسافة بين الأيقونة والاسم
              Text(
                label,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  color: isSelected
                      ? ColorsManager.white
                      : ColorsManager.white.withOpacity(0.85),
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final horizontalPadding = width * 0.03;
    final verticalPadding = 3.0 + bottomPadding * 0.2;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          0,
          horizontalPadding,
          verticalPadding,
        ),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.black,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // ✅ وسط العناصر أفقيًا
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildItem(
                    context: context, icon: Icons.home_filled, label: 'Home', index: 0),
                _buildItem(
                    context: context, icon: Icons.favorite, label: 'Favorite', index: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
