import 'package:flutter/material.dart';
import 'package:medial_match/providers/authentication_provider.dart';
import 'package:provider/provider.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profilePicture =
        context.watch<IAuthenticationProvider>().user!.profilePicture;

    return FutureBuilder(
      future: profilePicture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: AssetImage(
              "assets/images/missing_profile.png",
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: MemoryImage(snapshot.data!),
          );
        } else {
          return const CircleAvatar(
            backgroundColor: Colors.black,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
