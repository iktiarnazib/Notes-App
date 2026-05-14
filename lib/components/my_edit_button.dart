import 'package:flutter/material.dart';

class MyEditButton extends StatelessWidget {
  final void Function()? onTap;
  const MyEditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),

      child: IconButton(onPressed: onTap, icon: Icon(Icons.edit)),
    );
  }
}
