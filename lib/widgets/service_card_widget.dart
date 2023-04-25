import 'package:flutter/material.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/screens/service_detail_screen.dart';
import 'package:medial_match/widgets/image_content_loader_widget.dart';

/// Show a [Service] in a [Card] to be picked, when clicked pushed a [ServiceDetailScreen]
class ServiceCardWidget extends StatelessWidget {
  const ServiceCardWidget({
    required this.service,
    this.memoryLoadedImage,
    super.key,
  });

  final Service service;
  final Widget? memoryLoadedImage;

  @override
  Widget build(BuildContext context) {
    Widget? contentMemoryLoadedImage;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ServiceDetailScreen(
            service: service,
            memoryLoadedImage: memoryLoadedImage ?? contentMemoryLoadedImage,
          ),
        ),
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 6 / 4,
              child: NotificationListener<OnImageContentLoaded>(
                onNotification: (notification) {
                  contentMemoryLoadedImage = notification.content;

                  return true;
                },
                child: memoryLoadedImage ??
                    ImageContentLoaderWidget(
                      imageFuture: service.image,
                      shouldNotifyLoad: true,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(service.name),
            ),
          ],
        ),
      ),
    );
  }
}
