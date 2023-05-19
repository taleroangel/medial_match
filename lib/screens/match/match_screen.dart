import 'package:flutter/material.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:medial_match/widgets/request_card_widget.dart';
import 'package:provider/provider.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = context
        .read<AbstractAuthenticationProvider>()
        .user!
        .requests
        .map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RequestCardWidget(request: e),
            ));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar.large(
            title: Text.rich(TextSpan(children: [
              TextSpan(
                text: "¡Es un Match!",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
            ])),
          ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                "Aquí se encuentran registradas todas tus solicitudes, "
                "selecciona una de ellas para ver las ofertas",
              ),
            ),
          ),

          // List builder
          SliverList.builder(
            itemCount: offers.length,
            itemBuilder: (_, index) => offers.elementAt(index),
          ),
        ],
      ),
    );
  }
}
