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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {/* TODO: Pantalla de Cotización */},
          icon: const Icon(Icons.back_hand_rounded),
          label: const Text("Cotizar!"),
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
                    heroTag: "service@${service.id}",
                  ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                service.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            // Estimated price
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text.rich(
                TextSpan(children: [
                  const TextSpan(text: "Precio Estimado:\n"),
                  TextSpan(
                    text: service.price ?? "No hay estimado de precios",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ]),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                service.description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox.square(dimension: 80.0),
          ]),
        ),
      );
}
