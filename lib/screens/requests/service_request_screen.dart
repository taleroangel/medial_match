import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/delegates/services_search_delegate.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:medial_match/widgets/service_card_widget.dart';

class ServiceRequestScreen extends StatelessWidget {
  const ServiceRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // Get services and fit them into widgets
    final services = GetIt.I
        .get<IDatabaseService>()
        .services
        .map((e) => ServiceCardWidget(service: e))
        .toList();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar.large(
            title: const Text("Solicitar un Servicio"),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(21.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text:
                            "¿Necesitas ayuda escogiendo el servicio adecuado?\n",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                            onPressed: () {/* TODO: ChatBot Screen */},
                            icon: const Icon(Icons.chat),
                            label: const Text("Habla con un ChatBot"),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => showSearch(
                    context: context,
                    delegate: ServicesSearchDelegate(),
                    useRootNavigator: true,
                  ),
                  icon: const Icon(Icons.search_outlined),
                  label: const Text("Buscar un Servicio"),
                ),
                MasonryGridView.count(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: services.length,
                  crossAxisCount: 2,
                  itemBuilder: (_, index) => services[index],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
