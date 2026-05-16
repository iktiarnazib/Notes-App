import 'package:flutter/material.dart';
import 'package:notesapp2/components/lottie_and_title.dart';
import 'package:notesapp2/components/my_key_button.dart';
import 'package:notesapp2/components/my_style_button.dart';
import 'package:notesapp2/helper/helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Stack(
        children: [
          //horizontal scrollable pages
          PageView(
            children: [
              LottieAndTitle(
                lottieLocation: Helper.noteLottie,
                title: Helper.noteTitle,
                description: Helper.noteDescription,
              ),
              LottieAndTitle(
                lottieLocation: Helper.lockLottie,
                title: Helper.lockTitle,
                description: Helper.lockDescription,
              ),
              LottieAndTitle(
                lottieLocation: Helper.celebrateLottie,
                title: Helper.celebrateTitle,
                description: Helper.celebrateDescription,
              ),
            ],
          ),

          //skip button
          Positioned(
            top: 50,
            right: 10,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(surfaceTintColor: Colors.red),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontFamily: 'DMSerifText',
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),

          //dot naviagtion of smoothPageIndicator
          Positioned(
            left: TSizes.defaultSpace,
            bottom: 60,
            child: SmoothPageIndicator(
              controller: PageController(),
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).colorScheme.inversePrimary,
                dotColor: Theme.of(context).colorScheme.secondary,
                dotHeight: 6,
              ),
            ),
          ),

          //Circular button
          Positioned(
            right: 30,
            bottom: 45,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text('Next'), Icon(Icons.arrow_right)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
