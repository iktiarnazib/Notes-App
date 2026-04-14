import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notesapp2/pages/intro_page.dart';
import 'package:notesapp2/pages/notes_page.dart';
import 'package:notesapp2/pages/settings_page.dart';
import 'package:notesapp2/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize isar database
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      theme: themeMode,
      color: Theme.of(context).colorScheme.surface,
      routes: {
        'notesPage': (context) => const NotesPage(),
        'settingsPage': (context) => const SettingsPage(),
        'introPage': (context) => const IntroPage(),
      },
    );
  }
}
