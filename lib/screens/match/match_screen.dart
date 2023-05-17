import 'package:flutter/material.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:provider/provider.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offers =
        context.read<AbstractAuthenticationProvider>().user!.requests;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar.large(
            title: Text(
              "¡Es un Match!",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          // Body
          SliverToBoxAdapter(
            child: Column(
              children: offers
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
        ],
      ),
    );
  }
}
