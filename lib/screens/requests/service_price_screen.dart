import 'package:flutter/material.dart';
import 'package:medial_match/models/service.dart';

class ServicePriceScreen extends StatefulWidget {
  const ServicePriceScreen({required this.service, super.key});

  final Service service;

  @override
  State<ServicePriceScreen> createState() => _ServicePriceScreenState();
}

class _ServicePriceScreenState extends State<ServicePriceScreen> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Crear una cotización"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Describe el servicio\n",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const TextSpan(
                      text: "Describe brevemente tu solicitud",
                    ),
                  ]),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox.square(dimension: 32.0),
              // TextBox
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                ),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  // Create request

                  // Show message
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Se ha creado la nueva solicitud"),
                  ));

                  // Return to main
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.handshake_rounded),
                label: const Text("Empezar una subasta"),
              ),
            ],
          ),
        ),
      );
}
