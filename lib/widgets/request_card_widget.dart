import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medial_match/extensions/unix_time.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/screens/match/request_detail_screen.dart';
import 'package:medial_match/widgets/service_tile_widget.dart';

class RequestCardWidget extends StatelessWidget {
  const RequestCardWidget({
    required this.request,
    super.key,
  });

  final Request request;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat("dd/MM/yyyy");

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => RequestDetailScreen(request: request),
      )),
      child: Card(
        elevation: 1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Petición #${request.id}\n",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextSpan(
                      text: "Tienes ${request.offers.length} ofertas",
                    ),
                  ])),
                  const Spacer(),
                  Badge(
                    largeSize: 32.0,
                    label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Registrada: ${dateFormat.format(
                          request.date.asUnixTime,
                        )}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Service card
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                child: AbsorbPointer(
                  child: ServiceTileWidget(
                    service: request.service,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
