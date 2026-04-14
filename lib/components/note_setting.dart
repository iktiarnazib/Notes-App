import 'package:flutter/material.dart';

class NoteSetting extends StatelessWidget {
  final Function()? onEditTap;
  final Function()? onDeleteTap;
  const NoteSetting({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //edit button
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEditTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(child: Text('Edit')),
          ),
        ),

        //delete button
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(child: Text('Delete')),
          ),
        ),
      ],
    );
  }
}
