import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medial_match/screens/requests/requests_screen.dart';
import 'package:medial_match/services/database_service.dart';
import 'package:medial_match/widgets/news_card_widget.dart';
import 'package:medial_match/widgets/profile_picture_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              expandedHeight: 200,
              collapsedHeight: 120,
              toolbarHeight: 100,
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Bienvenido\n",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    TextSpan(
                      text: "Lorem Ipsum",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              actions: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox.square(
                    dimension: 50.0,
                    child: ProfilePictureWidget(),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Buttons
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 16.0,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RequestsScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.back_hand),
                          label: const Text("Solicitar Servicio"),
                        ),
                        Badge.count(
                          count: 3,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.handshake_rounded),
                            label: const Text("Mis Solicitudes"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Novedades y Noticias:",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  CarouselSlider(
                    items: GetIt.I
                        .get<IDatabaseService>()
                        .news
                        .map((e) => NewsCardWidget(news: e))
                        .toList(),
                    options: CarouselOptions(
                      aspectRatio: 1,
                    ),
                  ),
                  const SizedBox.square(
                    dimension: 32.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
