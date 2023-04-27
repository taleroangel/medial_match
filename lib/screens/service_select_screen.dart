import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/delegates/services_search_delegate.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:medial_match/widgets/service_card_widget.dart';

class ServiceSelectScreen extends StatelessWidget {
  const ServiceSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get services and fit them into widgets
    final services = GetIt.I
        .get<IDatabaseService>()
        .services
        .map((e) => ServiceCardWidget(service: e))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicios Disponibles"),
        actions: [
          TextButton(
            onPressed: () => showSearch(
              context: context,
              delegate: ServicesSearchDelegate(),
              useRootNavigator: true,
            ),
            child: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: MasonryGridView.count(
        itemCount: services.length,
        crossAxisCount: 2,
        itemBuilder: (_, index) => services[index],
      ),
    );
  }
}
