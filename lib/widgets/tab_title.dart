import 'package:flutter/material.dart';

class TabTitle extends StatelessWidget {
  final String text;

  const TabTitle({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 7.0,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.0,
            letterSpacing: 3.0,
            color: Color(0xff011313),
          ),
        ),
      ),
    );
  }
}
