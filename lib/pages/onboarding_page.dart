import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:notesapp2/components/lottie_and_title.dart';
import 'package:notesapp2/helper/helper.dart';
import 'package:notesapp2/pages/notes_page.dart';
import 'package:notesapp2/provider/onboarding_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(onboardingProvider.notifier);
    final next = ref.watch(onboardingProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: Stack(
        children: [
          //horizontal scrollable pages
          Positioned.fill(
            child: PageView(
              controller: controller.pageContoller,
              onPageChanged: controller.updatePageIndicator,
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
          ),

          //skip button
          Positioned(
            top: 50,
            right: 10,
            child: TextButton(
              onPressed: () {
                controller.onSkipClick();
              },
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
              onDotClicked: controller.onDotClickUpdate,
              controller: controller.pageContoller,
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
            child: ElevatedButton(
              onPressed: () async {
                if (next == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NotesPage();
                      },
                    ),
                  );
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('onboarding', false);
                } else {
                  controller.nextPage();
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  next == 2 ? Text('Get Started') : Text('Next'),
                  SizedBox(width: 4),
                  Icon(
                    Iconsax.arrow_right_3,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
