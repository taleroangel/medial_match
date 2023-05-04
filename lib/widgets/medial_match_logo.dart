import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class MedialMatchLogo extends StatelessWidget {
  const MedialMatchLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture(
      const AssetBytesLoader("assets/svg/medial_match.vec"),
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onPrimary,
        BlendMode.srcIn,
      ),
    );
  }
}
