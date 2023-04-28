import 'package:flutter/material.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/screens/requests/service_detail_screen.dart';
import 'package:medial_match/widgets/image_content_loader_widget.dart';

class ServiceTileWidget extends StatelessWidget {
  const ServiceTileWidget({required this.service, super.key});

  final Service service;

  @override
  Widget build(BuildContext context) {
    Widget? memoryLoadedImage;

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ServiceDetailScreen(
          service: service,
          memoryLoadedImage: memoryLoadedImage,
        ),
      )),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: LayoutBuilder(
          builder: (_, constraints) => SizedBox(
            width: constraints.maxHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              clipBehavior: Clip.hardEdge,
              child: NotificationListener<OnImageContentLoaded>(
                onNotification: (notification) {
                  memoryLoadedImage = notification.content;

                  return true;
                },
                child: ImageContentLoaderWidget(
                  imageFuture: service.image,
                  shouldNotifyLoad: true,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          service.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          service.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
