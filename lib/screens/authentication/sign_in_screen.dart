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

  void authenticate() {
    // Check non-empty fields
    if (emailInputController.text.isEmpty ||
        passwordInputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Debes digitar tu email y contraseña"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    }

    // Try to authenticate
    context
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
  }

  void forgotPassword() {
    // Validate email
    if (emailInputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Escribe primero tu email"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    }

    // Try to recover password
    context
        .read<IAuthenticationProvider>()
        .forgotPassword(emailInputController.text)
        .then((emailSuccess) {
      if (emailSuccess) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text(
              "Revisa tu correo, se han enviado las instrucciones de recuperación",
            ),
            actions: [
              ElevatedButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("Aceptar"),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              "No se ha podido enviar el mensaje de recuperación",
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });
  }

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
                  decoration: inputDecoration(colorScheme, "Correo"),
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
                  decoration: inputDecoration(colorScheme, "Contraseña"),
                  style: TextStyle(color: colorScheme.onPrimary),
                ),
              ),

              // Forgot password
              TextButton(
                onPressed: forgotPassword,
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
                  onPressed: authenticate,
                  child: const Text("Iniciar Sesión"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(ColorScheme colorScheme, String label) =>
      InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.onPrimary),
        filled: true,
        fillColor: colorScheme.onPrimaryContainer,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      );
}
