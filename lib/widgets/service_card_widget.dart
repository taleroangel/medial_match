import 'package:flutter/material.dart';
import 'package:medial_match/models/service.dart';

class ServiceCardWidget extends StatelessWidget {
  const ServiceCardWidget({required this.service, super.key});

  final Service service;

  @override
  Widget build(BuildContext context) => Card(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: FutureBuilder(
                  future: service.image,
                  builder: (context, snapshot) => Placeholder(),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(service.name),
              ),
            ),
          ],
        ),
      );
}
