import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp2/components/my_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.notes,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            SizedBox(height: 15),
            //title
            FittedBox(
              child: Text(
                'Clean Notes',
                style: GoogleFonts.dmSerifText(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            SizedBox(height: 5),
            //subtitle
            FittedBox(
              child: Text(
                'Remember what you do everyday',
                style: GoogleFonts.dmSerifText(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 30),
            //enter button
            MyButton(
              onTap: () {
                Navigator.pushReplacementNamed(context, 'notesPage');
              },
              child: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
