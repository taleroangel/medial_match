import 'package:flutter/material.dart';
import 'package:medial_match/models/contract.dart';
import 'package:medial_match/models/user.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    required this.contract,
    super.key,
  });

  final Contract contract;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Escribe un mensaje",
                    suffixIcon: Icon(Icons.send),
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
