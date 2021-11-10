import 'package:flutter/material.dart';

class HeadingAndDivider extends StatelessWidget {
  final String heading;

  const HeadingAndDivider({Key? key, required this.heading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(heading, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
      const Divider(height: 4, endIndent: 10, indent: 10)
    ]);
  }
}
