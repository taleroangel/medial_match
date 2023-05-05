import 'package:flutter/material.dart';
import 'package:medial_match/models/user.dart';
import 'package:medial_match/providers/mock/mock_authentication_provider.dart';
import 'package:medial_match/widgets/profile_picture_widget.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar.large(
              title: Text(
                "¡Es un Match!",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            // Body
            SliverToBoxAdapter(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                children: [
                  FreelanceDescriptionCard(),
                ],
              ),
            ),
          ],
        ),
      );
}

class FreelanceDescriptionCard extends StatelessWidget {
  FreelanceDescriptionCard({
    super.key,
  }) : user = MockAuthenticationProvider.mockUser;

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ProfilePictureWidget(
            data: user.profilePicture,
          ),
          Text(user.name),
        ],
      ),
    );
  }
}
