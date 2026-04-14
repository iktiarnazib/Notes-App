import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp2/themes/theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

var switchOn = false;

class _SettingsPageState extends ConsumerState<SettingsPage> {
  void onSwitchPressed() {
    if (ref.read(themeProvider) == lightMode) {
      ref.read(themeProvider.notifier).state = darkMode;
    } else {
      ref.read(themeProvider.notifier).state = lightMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings', style: GoogleFonts.dmSerifText())),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(14.0),
          margin: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Dark Mode',
                  style: GoogleFonts.dmSerifText(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Switch.adaptive(
                  value: switchOn,
                  onChanged: (value) {
                    setState(() {
                      onSwitchPressed();
                      switchOn = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
