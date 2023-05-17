import 'package:flutter/material.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:medial_match/widgets/profile_picture_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AbstractAuthenticationProvider>().user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Usuario"),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.read<AbstractAuthenticationProvider>().signOut();
            },
            icon: const Icon(Icons.outbond_rounded),
            label: const Text("Cerrar Sesión"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Actualizar Datos"),
        icon: const Icon(Icons.edit),
      ),
      body: Center(
        child: Column(
          children: [
            // Profile picture
            const Spacer(flex: 3),
            const _ProfilePhoto(),
            const Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: '${user.name}\n',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  TextSpan(
                    text: user.type.text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontFamily: 'MedialOne',
                      fontSize: 32.0,
                    ),
                  ),
                ]),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
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
