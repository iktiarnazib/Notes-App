import 'package:flutter/material.dart';

class MyStyleButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final Color? iconColor;
  const MyStyleButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),

      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: iconColor),
      ),
    );
  }
}
