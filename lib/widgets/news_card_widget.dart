import 'package:flutter/material.dart';
import 'package:medial_match/models/news.dart';
import 'package:medial_match/widgets/image_content_loader_widget.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    required this.news,
    this.memoryLoadedImage,
    super.key,
  });

  final News news;
  final Widget? memoryLoadedImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 6 / 4,
            child: memoryLoadedImage ??
                ImageContentLoaderWidget(
                  imageFuture: news.imageContent,
                  heroTag: news.imageUrl,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Text(
              news.content,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
