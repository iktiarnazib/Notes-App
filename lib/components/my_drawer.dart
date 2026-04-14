import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  final Function()? onTap;

  const MyDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.notes,
              size: 120,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Text(
            'Notes',
            style: GoogleFonts.dmSerifText(
              fontSize: 30,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            title: Text(
              'Home',
              style: GoogleFonts.dmSerifText(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 17,
              ),
            ),
            onTap: onTap,
          ),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            title: Text(
              'Settings',
              style: GoogleFonts.dmSerifText(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 17,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'settingsPage');
            },
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.exit_to_app_sharp,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              title: Text(
                'Exit',
                style: GoogleFonts.dmSerifText(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 17,
                ),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, 'introPage', (
                  route,
                ) {
                  return false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
