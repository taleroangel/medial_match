import 'package:flutter/material.dart';
import 'package:medial_match/models/offer.dart';
import 'package:medial_match/models/request.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:medial_match/widgets/profile_picture_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medial_match/extensions/price_formatter.dart';
import 'package:provider/provider.dart';

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen({
    required this.request,
    required this.offer,
    super.key,
  });

  final Request request;
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final authProvider =
        Provider.of<AbstractAuthenticationProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Detalles de la Oferta")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ProfilePictureWidget(
                      data: offer.freelancer.profilePicture,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          offer.freelancer.name,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        RatingBar.builder(
                          itemSize: 28.0,
                          initialRating: offer.freelancer.stars,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onRatingUpdate: (_) => _,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox.square(dimension: 18),

            Text.rich(TextSpan(children: [
              const TextSpan(text: "Precio ofrecido:\n"),
              TextSpan(
                text: offer.price.asPrice,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ])),

            const SizedBox.square(dimension: 18),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    actions: [
                      // Cancel
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text("Cancelar"),
                      ),

                      // Accept
                      ElevatedButton(
                        onPressed: () {
                          authProvider.userAcceptOffer(request, offer);

                          Navigator.of(dialogContext)
                              .popUntil((route) => route.isFirst);
                        },
                        child: const Text("Continuar"),
                      ),
                    ],
                    title: const Text(
                      "Realizar pago",
                    ),
                    content: Text(
                      "A continuación realizarás el pago de ${offer.price.asPrice}",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Aceptar oferta",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            ElevatedButton.icon(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.arrow_back),
              label: const Text("Regresar"),
            ),
          ],
        ),
      ),
    );
  }
}
