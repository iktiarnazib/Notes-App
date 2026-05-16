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
              Lottie.asset(
                Helper.noteLottie,
                height: 200,
                fit: BoxFit.contain,
                repeat: false,
              ),
              Lottie.asset(
                Helper.lockLottie,
                height: 200,
                fit: BoxFit.contain,
                repeat: false,
              ),
              Lottie.asset(
                Helper.celebrateLottie,
                height: 200,
                fit: BoxFit.contain,
                repeat: false,
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
