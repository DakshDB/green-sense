import 'package:flutter/material.dart';
import 'package:green_sense/utilities/launch_url.dart';

import '../widgets/custom_text.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.78,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: "Contact",
                textSize: 16.0,
                color: Color(0xff011313),
                letterSpacing: 3.0,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const CustomText(
                text: "Get In Touch",
                textSize: 42.0,
                color: Colors.black,
                letterSpacing: 3.0,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Wrap(
                children: [
                  Text(
                    "Green Sense is focused on spreading awareness about the environment and the importance of sustainable living.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      letterSpacing: 0.75,
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),
              OutlinedButton(
                onPressed: () {
                  launchEmail();
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  side: const BorderSide(width: 1.0, color: Color(0xff011313)),
                ),
                child: const Text(
                  "Get In Touch",
                  style: TextStyle(
                    color: Color(0xff011313),
                    letterSpacing: 2.75,
                    wordSpacing: 1.0,
                    fontSize: 15.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
