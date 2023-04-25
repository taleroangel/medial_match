import 'package:flutter/material.dart';
import 'package:medial_match/models/service.dart';

class ServiceCardWidget extends StatelessWidget {
  const ServiceCardWidget({required this.service, super.key});

  final Service service;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(service.name),
        subtitle: Text(service.description),
      );
}
