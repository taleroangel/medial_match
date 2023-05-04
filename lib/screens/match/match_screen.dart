import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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
              child: Column(children: []),
            ),
          ],
        ),
      );
}
