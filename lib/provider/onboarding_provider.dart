import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateNotifierProvider((ref) => OnboardingNotifier());

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);

  //page controller
  final pageContoller = PageController();

  //on page scroll update
  void updatePageIndicator(int index) {
    state = index;
  }

  //on dot click update
  void onDotClickUpdate(int index) {
    state = index;
    pageContoller.jumpToPage(state);
  }

  //on nextpage update dot
  void nextPage() {
    if (state == 2) {
    } else {
      state++;
      pageContoller.jumpToPage(state);
    }
  }

  //on skip click
  void onSkipClick() {
    state = 2;
    pageContoller.jumpToPage(state);
  }
}
