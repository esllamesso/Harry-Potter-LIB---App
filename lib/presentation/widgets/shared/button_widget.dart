import 'package:flutter/material.dart';
import 'package:book_app/core/utils/colors_manager.dart';

class ButtonWidget extends StatefulWidget {
  final String text;
  final Color color;
  final double? width;
  final double? height;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
    this.width,
    this.height,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenWidth * 0.0,
        screenHeight * 0.05,
        screenWidth * 0.0,
        screenHeight * 0.03,
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorsManager.black,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: widget.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
