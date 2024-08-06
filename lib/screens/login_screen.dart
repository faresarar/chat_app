import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B475E),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Image.asset("assets/images/scholar.png"),
            const Text(
              "Scholar Chat",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontFamily: "pacifico",
              ),
            ),
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const CustomTextField(
              hintText: "Email",
            ),
            const CustomTextField(
              hintText: "Password",
            ),
            const CustomButton()
          ],
        ),
      ),
    );
  }
}
