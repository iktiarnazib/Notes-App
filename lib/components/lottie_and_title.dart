import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp2/helper/helper.dart';

class LottieAndTitle extends StatelessWidget {
  final String lottieLocation;
  final String title;
  final String description;
  const LottieAndTitle({
    super.key,
    required this.lottieLocation,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 30),
          //lottie
          Expanded(
            child: Lottie.asset(
              lottieLocation,
              height: MediaQuery.of(context).size.height * .65,
              fit: BoxFit.contain,
              repeat: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'DMSerifText',
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 25,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'DMSerifText',
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 150),
        ],
      ),
    );
  }
}
