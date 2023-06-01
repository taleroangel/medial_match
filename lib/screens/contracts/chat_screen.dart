import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:medial_match/mocks/mock_model_generator.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/models/user.dart';
import 'package:medial_match/providers/abstract_authentication_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    required this.initialContract,
    super.key,
  });

  final Contract initialContract;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AbstractAuthenticationProvider>();
    final colorScheme = Theme.of(context).colorScheme;

    final contract =
        authProvider.user!.contracts.where((e) => e == initialContract).first;

    return Scaffold(
      appBar: AppBar(title: Text("Chat con ${contract.freelancer.name}")),
      body: Stack(
        children: [
          ListView.builder(
            reverse: true,
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 120.0,
            ),
            shrinkWrap: true,
            itemCount: contract.chat.length,
            itemBuilder: (context, index) {
              final message = contract.chat[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 16.0,
                ),
                child: Card(
                  margin: EdgeInsets.only(
                    left: message.who == UserType.client ? 32.0 : 0.0,
                    right: message.who == UserType.freelancer ? 32.0 : 0.0,
                  ),
                  color: switch (message.who) {
                    UserType.client => colorScheme.primaryContainer,
                    UserType.freelancer => colorScheme.onPrimaryContainer
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: switch (message.who) {
                          UserType.client => colorScheme.onPrimaryContainer,
                          UserType.freelancer => colorScheme.primaryContainer
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Show Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(32.0),
                  border: Border.all(
                    color: colorScheme.onBackground,
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Escribe un mensaje",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        GetIt.I.get<Logger>().d("Send message");
                        authProvider.message(
                          contract,
                          MockModelGenerator.mockParagraph(1),
                        );
                      },
                      child: const Icon(Icons.send),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
