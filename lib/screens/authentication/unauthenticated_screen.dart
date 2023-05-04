import 'package:flutter/material.dart';
import 'package:medial_match/screens/authentication/sign_in_screen.dart';
import 'package:medial_match/widgets/medial_match_logo.dart';
import 'package:medial_match/widgets/medial_match_text.dart';

class UnauthenticatedScreen extends StatelessWidget {
  const UnauthenticatedScreen({super.key});

  /// Push [SignInScreen] route for authentication
  void signIn(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => const SignInScreen(),
      ));

  //TODO: Push routes
  void signUp(BuildContext context) {}

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(children: [
          const Expanded(
            flex: 4,
            child: MedialMatchLogo(),
          ),
          const Expanded(
            flex: 2,
            child: Hero(
              tag: "text:medial_match",
              child: MedialMatchText(),
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
