import 'package:flutter/material.dart';
import 'package:medial_match/models/user.dart';
import 'package:medial_match/widgets/profile_picture_widget.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Gestión de Usuario")),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text("Actualizar"),
          icon: const Icon(Icons.edit),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Profile picture
                const SizedBox.square(dimension: 16.0),
                const _ProfilePhoto(),
                const SizedBox.square(dimension: 24.0),
                // User type selection
                Text.rich(
                  TextSpan(text: "Tipo de usuario: ", children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SegmentedButton<UserType>(
                        onSelectionChanged: (userType) {},
                        segments: UserType.values
                            .map((e) => ButtonSegment<UserType>(
                                  value: e,
                                  label: Text(e.text),
                                ))
                            .toList(),
                        selected: const {UserType.client},
                      ),
                    ),
                  ]),
                ),
                // History buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 8.0,
                  ),
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Historial de Servicios"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Historial de Solicitudes"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _ProfilePhoto extends StatelessWidget {
  const _ProfilePhoto();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SizedBox.square(
          dimension: 180,
          child: ProfilePictureWidget(),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            child: const Icon(Icons.photo),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {},
            child: const Icon(Icons.camera),
          ),
        ),
      ],
    );
  }
}
