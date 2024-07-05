import 'package:flutter/material.dart';

import '../widgets/custom_text.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          SizedBox(
            height: size.height * 0.4,
            child: const Image(
              fit: BoxFit.cover,
              image: AssetImage("images/logo.png"),
            ),
          ),
          const CustomText(
            text: "Green Sense",
            textSize: 68.0,
            color: Color(0xff033722),
            fontWeight: FontWeight.w900,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4.0,
          ),
          const Wrap(
            children: [
              CustomText(
                text: "Every green seed of awareness grows a brighter future",
                textSize: 20.0,
                color: Color(0xff176637),
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
