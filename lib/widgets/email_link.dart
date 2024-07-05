import 'package:flutter/material.dart';
import 'package:green_sense/constants/info.dart';

class EmailLink extends StatelessWidget {
  const EmailLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var ratio = size.width > 800 ? 0.06 : (size.width > 450 ? 0.09 : 0.12);
    return SizedBox(
      width: size.width * ratio,
      height: size.height * 0.9,
      //color: Colors.orange,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RotatedBox(
              quarterTurns: 45,
              child: Text(
                emailID,
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.6),
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Container(
                height: 100,
                width: 2,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
