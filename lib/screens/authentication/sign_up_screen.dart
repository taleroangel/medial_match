import 'package:flutter/material.dart';
import 'package:medial_match/models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controladores del form
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  void dispose() {
    nameInputController.dispose();
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  var acceptsTermsOfService = false;
  var userType = UserType.client;

  void createAccount() {
    // Validate terms of service
    if (!acceptsTermsOfService) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Debes aceptar los términos de servicio"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    }

    // Validate fields
    if (nameInputController.text.isEmpty ||
        emailInputController.text.isEmpty ||
        passwordInputController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Debes diligenciar todos los campos"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );

      return;
    }

    //TODO: Create accout
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text("Crea una cuenta"),
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Welcome message
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 16.0,
              ),
              child: Text(
                "Nisi reprehenderit adipisicing enim labore et.",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: colorScheme.inversePrimary),
              ),
            ),
            // Text fields
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameInputController,
                      keyboardType: TextInputType.name,
                      decoration: inputDecoration(colorScheme, "Nombre"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: emailInputController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputDecoration(colorScheme, "Correo"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordInputController,
                      obscureText: true,
                      decoration: inputDecoration(colorScheme, "Contraseña"),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Terms of Service
            Text.rich(
              TextSpan(children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Checkbox(
                    side: const BorderSide(
                      style: BorderStyle.solid,
                    ),
                    visualDensity: VisualDensity.compact,
                    value: acceptsTermsOfService,
                    onChanged: (value) => setState(() {
                      acceptsTermsOfService = value!;
                    }),
                  ),
                ),
                const TextSpan(
                  text: "Acepto los términos y condiciones de uso",
                ),
              ]),
              style: TextStyle(color: colorScheme.onPrimary),
              textAlign: TextAlign.center,
              softWrap: true,
            ),

            // User selection type
            SegmentedButton(
              segments: UserType.values
                  .map(
                    (e) => ButtonSegment(
                      value: e,
                      icon: const Icon(Icons.circle),
                      label: Text(e.text),
                    ),
                  )
                  .toList(),
              selected: {userType},
              onSelectionChanged: (type) => setState(() {
                userType = type.first;
              }),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => (states.contains(MaterialState.selected)
                      ? Theme.of(context).colorScheme.inversePrimary
                      : Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),

            // Create button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: createAccount,
                icon: const Icon(Icons.waving_hand),
                label: const Text("Crea mi cuenta"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(ColorScheme colorScheme, String label) =>
      InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorScheme.onPrimary),
        filled: true,
        isDense: true,
        fillColor: colorScheme.onPrimaryContainer,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      );
}
