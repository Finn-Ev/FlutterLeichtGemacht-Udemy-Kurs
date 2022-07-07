import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const SignUpButton({required this.text, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: themeData.colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: themeData.textTheme.button?.copyWith(
            color: themeData.colorScheme.onSecondary,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
