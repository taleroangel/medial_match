import 'package:flutter/material.dart';
import 'package:medial_match/exceptions/authentication_exception.dart';
import 'package:medial_match/providers/authentication_provider.dart';
import 'package:medial_match/widgets/medial_match_text.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  void authenticate(BuildContext context) => context
          .read<IAuthenticationProvider>()
          .authenticate(emailInputController.text, passwordInputController.text)
          .then((user) {
        // Show welcome message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Bienvenido ${user.name}"),
          ),
        );
        // Go back to previous route
        Navigator.of(context).pop();
      })
          // Catch authentication error
          .onError<AuthenticationException>(
        (error, stackTrace) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );

  void forgotPassword(BuildContext context) {}

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Iniciar Sesión"),
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextLogo
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Hero(
                  tag: "text:medial_match",
                  child: MedialMatchText(),
                ),
              ),
              // Email field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText: "Correo",
                    labelStyle: TextStyle(color: colorScheme.onPrimary),
                    filled: true,
                    fillColor: colorScheme.onPrimaryContainer,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
              ),

              // Password field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordInputController,
                  obscureText: true,
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    labelStyle: TextStyle(color: colorScheme.onPrimary),
                    filled: true,
                    fillColor: colorScheme.onPrimaryContainer,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
              ),

              // Forgot password
              TextButton(
                onPressed: () => forgotPassword(context),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.onPrimaryContainer,
                ),
                child: const Text("¿Olvidaste tu contraseña?"),
              ),

              // SignIn button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  onPressed: () => authenticate(context),
                  child: const Text("Iniciar Sesión"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
