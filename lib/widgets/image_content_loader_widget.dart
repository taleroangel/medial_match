import 'dart:typed_data';

import 'package:flutter/material.dart';

/// Loads an [Image] from a [Uint8List] future, shows a [CircularProgressIndicator] while loading
/// and can emmit a [Notification] when the content is successfully loaded with the corresponding
/// widget wrapped in a [Hero]
class ImageContentLoaderWidget extends StatelessWidget {
  const ImageContentLoaderWidget({
    required this.imageFuture,
    this.shouldNotifyLoad = false,
    this.heroTag,
    super.key,
  });

  final Future<Uint8List> imageFuture;
  final bool shouldNotifyLoad;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: imageFuture,
      builder: (context, snapshot) {
        late Widget contentMemoryLoadedImage;

        if (snapshot.connectionState == ConnectionState.done) {
          // If image had an error
          if (snapshot.hasError) {
            contentMemoryLoadedImage = Image.asset(
              "assets/images/not_found.jpg",
              fit: BoxFit.cover,
            );
          }
          // If image success fully loaded
          else if (snapshot.hasData) {
            contentMemoryLoadedImage = Hero(
              tag: heroTag ?? snapshot.data!.hashCode,
              child: Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
              ),
            );
          }

          // Dispatch notification
          if (shouldNotifyLoad) {
            context.dispatchNotification(
              OnImageContentLoaded(contentMemoryLoadedImage),
            );
          }

          return contentMemoryLoadedImage;
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class OnImageContentLoaded extends Notification {
  const OnImageContentLoaded(this.content);
  final Widget content;
}
