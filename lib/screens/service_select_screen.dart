import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:medial_match/widgets/service_card_widget.dart';

class ServiceSelectScreen extends StatelessWidget {
  const ServiceSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = GetIt.I.get<IDatabaseService>().services;

    return Scaffold(
      appBar: AppBar(title: const Text("Servicios Disponibles")),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (_, index) =>
            ServiceCardWidget(service: services.elementAt(index)),
      ),
    );
  }
}
