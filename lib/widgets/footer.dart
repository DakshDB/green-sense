import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.05,
        //color: Colors.white,
        child: Text(
          "Green Sense",
          style: TextStyle(
            color: Colors.white.withOpacity(0.4),
            letterSpacing: 1.75,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
