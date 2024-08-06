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
            const Spacer(flex: 2,),
            Image.asset("assets/images/scholar.png"),
            const Text(
              "Scholar Chat",
              textAlign: TextAlign.center,
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
            const SizedBox(height: 20,),
            const CustomTextField(
              hintText: "Email",
            ),
            const SizedBox(height: 20,),
            const CustomTextField(
              hintText: "Password",
            ),
            const SizedBox(height: 10,),
            const CustomButton(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "don\'t have an account ?",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "  SignUp",
                  style: TextStyle(
                    color: Color(0xffC7EDE6),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }
}
