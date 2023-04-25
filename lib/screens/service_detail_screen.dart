import 'package:flutter/material.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/widgets/image_content_loader_widget.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({
    required this.service,
    this.memoryLoadedImage,
    super.key,
  });

  final Service service;
  final Widget? memoryLoadedImage;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Detalles del Servicio"),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // Show Image
            SizedBox(
              height: 300,
              width: double.infinity,
              child: memoryLoadedImage ??
                  ImageContentLoaderWidget(
                    imageFuture: service.image,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                service.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                service.description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
          ]),
        ),
      );
}
