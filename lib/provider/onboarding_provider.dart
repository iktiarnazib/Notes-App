import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateNotifierProvider((ref) => OnboardingNotifier());

class OnboardingNotifier extends StateNotifier<int> {
  OnboardingNotifier() : super(0);

  //page controller
  final pageContoller = PageController();
  //current page index
  int currentPageIndex = 0;

  //on page scroll update
  void updatePageIndicator(int index) {
    currentPageIndex = index;
  }

  //on dot click update
  void onDotClickUpdate(int index) {
    currentPageIndex = index;
  }

  //on nextpage update dot
  void nextPage() {
    currentPageIndex++;
  }

  //on skip click
  void onSkipClick() {
    currentPageIndex = 2;
  }
}
