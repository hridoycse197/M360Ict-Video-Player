import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SpaceVertical extends StatelessWidget {
  double vertical;
  SpaceVertical({super.key, required this.vertical});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: vertical);
  }
}

// ignore: must_be_immutable
class SpaceHorizontal extends StatelessWidget {
  double horizontal;
  SpaceHorizontal({super.key, required this.horizontal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: horizontal);
  }
}
