import 'package:flutter/material.dart';

class MyKeyButton extends StatefulWidget {
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const MyKeyButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  State<MyKeyButton> createState() => _MyKeyButtonState();
}

class _MyKeyButtonState extends State<MyKeyButton> {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: widget.onPressed,
      /*
       () {
        ref
            .read(noteProvider.notifier)
            .updateNote(
              id: id,
              newText: titleController2.text.trim(),
              newSubText: descriptionController2.text.trim(),
              timeStamp: DateTime.now(),
            );
        if (mounted) {
          Navigator.pop(context);
        }
      },
*/
      child: Text(
        widget.text,
        style: TextStyle(fontFamily: 'DMSerifText', fontSize: 16),
      ),
    );
  }
}
