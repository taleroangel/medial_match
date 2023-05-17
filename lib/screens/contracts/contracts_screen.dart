import 'package:flutter/material.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:provider/provider.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contracts =
        context.read<AbstractAuthenticationProvider>().user!.contracts;

    return Scaffold(
      appBar: AppBar(title: const Text("Contratos")),
      body: SingleChildScrollView(
        child: Column(
          children: contracts
              .map((e) => e.toJson())
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(e.toString()),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
