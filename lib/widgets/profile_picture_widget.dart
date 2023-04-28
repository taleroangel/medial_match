import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) => const CircleAvatar(
        backgroundColor: Colors.black,
        backgroundImage: AssetImage(
          "assets/images/missing_profile.png",
        ),
      );
}
