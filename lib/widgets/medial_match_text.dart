import 'package:flutter/material.dart';

class MedialMatchText extends StatelessWidget {
  const MedialMatchText({
    this.fontSize = 45.0,
    super.key,
  });

  final double fontSize;

  @override
  Widget build(BuildContext context) => Text.rich(
        const TextSpan(children: [
          TextSpan(text: "MEDIAL\n"),
          TextSpan(text: "MATCH"),
        ]),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Colors.white,
              fontSize: fontSize,
            ),
      );
}
