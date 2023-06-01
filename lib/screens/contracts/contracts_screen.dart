import 'package:flutter/material.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:medial_match/widgets/contract_card_widget.dart';
import 'package:provider/provider.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get all contracts as Widgets
    final contracts = context
        .watch<AbstractAuthenticationProvider>()
        .user!
        .contracts
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 8.0,
              ),
              child: ContractCardWidget(contract: e),
            ));

    return Scaffold(
      appBar: AppBar(title: const Text("Contratos")),
      body: contracts.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  "No tienes ningún contrato pendiente",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            )
          : ListView.builder(
              itemCount: contracts.length,
              itemBuilder: (context, index) => contracts.elementAt(index),
            ),
    );
  }
}
