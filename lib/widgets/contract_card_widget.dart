import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medial_match/extensions/price_formatter.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/screens/contracts/chat_screen.dart';
import 'package:medial_match/widgets/service_tile_widget.dart';
import 'package:medial_match/widgets/user_tile_widget.dart';
import 'package:medial_match/extensions/unix_time.dart';

class ContractCardWidget extends StatelessWidget {
  const ContractCardWidget({
    required this.contract,
    super.key,
  });

  final Contract contract;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat("dd/MM/yyyy");

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(
                  text: "Servicio #${contract.id}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Badge(
                          backgroundColor: colorScheme.primary,
                          label: Text(
                            dateFormat.format(contract.dueAt.asUnixTime),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Detalles del contrato:\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: contract.details),
                  ],
                ),
              ),
            ),
            const Divider(),

            // Show the service
            ServiceTileWidget(service: contract.service),

            // Show the freelancer
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: UserTileWidget(
                  user: contract.freelancer,
                  trailing: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        initialContract: contract,
                      ),
                    )),
                    child: const Icon(Icons.message_rounded),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                children: [
                  Badge(
                    largeSize: 32.0,
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Costo: ${contract.price.asPrice}"),
                    ),
                  ),
                  Badge(
                    largeSize: 32.0,
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Debe finalizarse: ${dateFormat.format(contract.dueAt.asUnixTime)}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
