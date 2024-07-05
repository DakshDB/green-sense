import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 100),
      height: size.height * 0.9,
      child: Column(
        children: [
          //About me title
          const Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 12.0,
              ),
              CustomText(
                text: "About",
                textSize: 26.0,
                color: Color(0xff011313),
                fontWeight: FontWeight.w700,
              ),
            ],
          ),

          SizedBox(
            height: size.height * 0.07,
          ),
          const Wrap(
            children: [
              CustomText(
                text:
                    "Green Sense is focused on spreading awareness about the environment and the importance of sustainable living.",
                textSize: 16.0,
                color: Color(0xff828DAA),
                letterSpacing: 0.75,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
