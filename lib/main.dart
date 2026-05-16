import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp2/onboarding/onboarding_page.dart';
import 'package:notesapp2/pages/intro_page.dart';
import 'package:notesapp2/pages/notes_page.dart';
import 'package:notesapp2/pages/settings_page.dart';
import 'package:notesapp2/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool initialized = prefs.getBool('initialized') ?? false;
  final bool isLightMode = prefs.getBool('lightmode') ?? true;

  //initialize isar database
  runApp(
    ProviderScope(
      overrides: [
        themeProvider.overrideWith((ref) => isLightMode ? lightMode : darkMode),
      ],
      child: MyApp(initialized: initialized),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  final bool initialized;

  const MyApp({super.key, required this.initialized});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: widget.initialized ? const NotesPage() : const IntroPage(),
      home: OnboardingPage(),
      theme: lightMode,
      color: Theme.of(context).colorScheme.surface,
      routes: {
        'notesPage': (context) => const NotesPage(),
        'settingsPage': (context) => const SettingsPage(),
        'introPage': (context) => const IntroPage(),
      },
    );
  }
}
