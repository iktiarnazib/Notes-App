import 'package:flutter/material.dart';
import 'package:notesapp2/components/note_setting.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final DateTime timestamp;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final void Function()? onTap;
  const NoteTile({
    super.key,
    required this.text,
    required this.timestamp,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.primary,
        ),
        margin: EdgeInsets.only(top: 10, left: 25, right: 25),
        child: ListTile(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  // Expanded(child: SizedBox()),
                  Text(
                    '${timestamp.month}/'
                    "${timestamp.day}/"
                    "${timestamp.year} "
                    "${timestamp.hour}:"
                    "${timestamp.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
