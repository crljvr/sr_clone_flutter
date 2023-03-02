/// This will be the UI Component Library for the SR Play Clone
library sr_showroom;

import 'package:flutter/material.dart';

/// The default button to use.
class MyButton extends StatelessWidget {
  /// Creates a default button
  const MyButton({required this.title, super.key});

  /// This is the title of the button.
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(title),
    );
  }
}
