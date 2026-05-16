import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notesapp2/helper/helper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Welcome', style: TextStyle(fontFamily: 'DMSerifText')),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          //horizontal scrollable pages
          PageView(
            children: [
              Column(
                children: [
                  //lottie
                  Lottie.asset(
                    Helper.noteLottie,
                    height: MediaQuery.of(context).size.height * .50,
                    fit: BoxFit.contain,
                    repeat: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      Helper.noteTitle,
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
                      Helper.noteDescription,
                      style: TextStyle(
                        fontFamily: 'DMSerifText',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Lottie.asset(
                    Helper.lockLottie,
                    height: MediaQuery.of(context).size.height * .50,
                    fit: BoxFit.contain,
                    repeat: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      Helper.lockTitle,
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
                      Helper.lockDescription,
                      style: TextStyle(
                        fontFamily: 'DMSerifText',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Lottie.asset(
                      Helper.celebrateLottie,
                      height: MediaQuery.of(context).size.height * 0.42,
                      fit: BoxFit.contain,
                      repeat: false,
                    ),
                  ),
                  SizedBox(height: 52),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      Helper.celebrateTitle,
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
                      Helper.celebrateDescription,
                      style: TextStyle(
                        fontFamily: 'DMSerifText',
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 16,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          //skip button

          //dot naviagtion of smoothPageIndicator

          //Circular button
        ],
      ),
    );
  }
}
