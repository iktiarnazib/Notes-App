import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp2/components/note_setting.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NoteTile({
    super.key,
    required this.text,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.primary,
      ),
      margin: EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: Text(text, style: GoogleFonts.dmSerifText()),
        trailing: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              showPopover(
                height: 100,
                width: 100,
                backgroundColor: Theme.of(context).colorScheme.surface,
                context: context,
                bodyBuilder: (context) {
                  return NoteSetting(
                    onEditTap: onEditPressed,
                    onDeleteTap: onDeletePressed,
                  );
                },
              );
            },
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
