import 'package:flutter/material.dart';
import 'package:medial_match/models/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medial_match/widgets/profile_picture_widget.dart';

class UserTileWidget extends StatelessWidget {
  const UserTileWidget({
    required this.user,
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: ProfilePictureWidget(data: user.profilePicture),
        title: Text(user.name),
        subtitle: RatingBar.builder(
          itemSize: 21.0,
          initialRating: user.stars,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
          ),
          onRatingUpdate: (_) => _,
        ),
      );
}
