import 'package:flutter/material.dart';
import 'package:medial_match/extensions/price_formatter.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/screens/match/offer_detail_screen.dart';
import 'package:medial_match/widgets/service_tile_widget.dart';
import 'package:medial_match/widgets/user_tile_widget.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen({
    required this.request,
    super.key,
  });

  final Request request;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Detalles de la petición"),
        ),
        body: request.offers.isEmpty
            ?
            // If empty
            Center(
                child: SizedBox.square(
                  dimension: 300,
                  child: Column(
                    children: [
                      Text(
                        "El amor tocó a mi puerta y yo estaba paseando al perro.",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Parece ser que no hay ofertas, regresa más tarde.",
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        "No busques más, ¡Aquí está tu media naranja!",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                      ),
                      child: Text.rich(TextSpan(children: [
                        const TextSpan(
                          text: "Detalles de tu Solicitud:\n",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: request.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ])),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: ServiceTileWidget(service: request.service),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      child: Text(
                        "Has recibido un total de ${request.offers.length} ofertas",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: request.offers.length,
                    itemBuilder: (context, index) {
                      final offer = request.offers.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => OfferDetailScreen(offer: offer),
                            ),
                          ),
                          child: Card(
                            child: UserTileWidget(
                              key: ObjectKey(offer.freelancer),
                              user: offer.freelancer,
                              trailing: Badge(
                                largeSize: 32.0,
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(offer.price.asPrice),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      );
}
