import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateNotifierProvider((ref) => OnboardingNotifier());

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);

  //on page scroll update
  void updatePageIndicator(int index) {
    state = index;
  }

  //on dot click update
  void onDotClickUpdate(int index) {
    state = index;
  }

  //on nextpage update dot
  void nextPage() {
    state++;
  }

  //on skip click
  void onSkipClick() {
    state = 2;
  }
}
