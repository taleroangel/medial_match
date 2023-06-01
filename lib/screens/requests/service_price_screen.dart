import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medial_match/extensions/unix_time.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/models/service.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:provider/provider.dart';

class ServicePriceScreen extends StatefulWidget {
  const ServicePriceScreen({required this.service, super.key});

  final Service service;

  @override
  State<ServicePriceScreen> createState() => _ServicePriceScreenState();
}

class _ServicePriceScreenState extends State<ServicePriceScreen> {
  final _textEditingController = TextEditingController();
  DateTime finishDatetime = DateTime.now();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("dd/MM/yyyy");

    return Scaffold(
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

            const SizedBox.square(dimension: 18.0),

            Text.rich(TextSpan(
              children: [
                const TextSpan(
                  text: "Fecha de Finalización: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: dateFormat.format(finishDatetime),
                ),
              ],
            )),

            // Date selector
            TextButton.icon(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 60)),
                ).then((selectedDatetime) {
                  // New selected datetime
                  if (selectedDatetime != null) {
                    setState(() {
                      finishDatetime = selectedDatetime;
                    });
                  }
                });
              },
              icon: const Icon(Icons.calendar_month),
              label: const Text("Seleccionar una fecha"),
            ),

            const SizedBox.square(dimension: 18.0),

            ElevatedButton.icon(
              onPressed: () {
                // Create request
                context
                    .read<AbstractAuthenticationProvider>()
                    .userCreateRequest(Request(
                      id: Random().nextInt(1024),
                      date: DateTime.now().unixTime,
                      service: widget.service,
                      offers: {},
                      description: _textEditingController.text,
                      dueAt: finishDatetime.unixTime,
                    ));

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
}
