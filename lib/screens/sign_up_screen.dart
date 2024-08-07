import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor ,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
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
              "SignUp",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              hintText: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              hintText: "Password",
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomButton(
              title: "SignUp",
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, "LoginScreen");
                  },
                  child: const Text(
                    "already have an account ?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  "  Login",
                  style: TextStyle(
                    color: Color(0xffC7EDE6),
                  ),
                ),
              ],
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );
  }
}
