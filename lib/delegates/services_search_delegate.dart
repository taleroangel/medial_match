import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:medial_match/widgets/service_tile_widget.dart';

class ServicesSearchDelegate extends SearchDelegate {
  /// All items in database
  late final databaseItems = GetIt.I.get<IDatabaseService>().services;

  /// Search results items
  var searchItems = <Service>{};

  @override
  String? get searchFieldLabel => "Buscar un Servicio";

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget? buildLeading(BuildContext context) => GestureDetector(
        onTap: Navigator.of(context).pop,
        child: const Icon(Icons.arrow_back_rounded),
      );

  @override
  Widget buildResults(BuildContext context) {
    // Search items
    searchItems = databaseItems
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toSet();

    return ListView.separated(
      itemCount: searchItems.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) =>
          ServiceTileWidget(service: searchItems.elementAt(index)),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => ListView.separated(
        itemCount: min(databaseItems.length, 10),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, index) =>
            ServiceTileWidget(service: databaseItems.elementAt(index)),
      );
}
