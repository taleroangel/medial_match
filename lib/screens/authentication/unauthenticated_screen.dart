import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medial_match/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

class UnauthenticatedScreen extends StatelessWidget {
  const UnauthenticatedScreen({super.key});

  //TODO: Push routes
  void signIn(BuildContext context) {
    final authService = context.read<IAuthenticationProvider>();
    authService.authenticate("", "");
  }

  //TODO: Push routes
  void signUp(BuildContext context) {
    signIn(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(children: [
          Expanded(
            flex: 4,
            child: SvgPicture(
              const AssetBytesLoader("assets/svg/medial_match.vec"),
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text.rich(
              const TextSpan(children: [
                TextSpan(text: "MEDIAL\n"),
                TextSpan(text: "MATCH"),
              ]),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.white, fontSize: 45),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: "Bienvenido\n",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        TextSpan(
                          text:
                              "Ipsum commodo consequat elit anim tempor qui culpa exercitation anim ut adipisicing.",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 32.0,
                      ),
                      child: Wrap(
                        spacing: 16.0,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => signIn(context),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            icon: const Icon(Icons.key_rounded),
                            label: const Text("Iniciar Sesión"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () => signUp(context),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            icon: const Icon(
                              Icons.face_retouching_natural_rounded,
                            ),
                            label: const Text("Crear Cuenta"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
}
