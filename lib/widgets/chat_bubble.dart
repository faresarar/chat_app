import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 150,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16),
      margin: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        color: kPrimaryColor,
      ),
      child: const Text(
        "I am a new user",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
