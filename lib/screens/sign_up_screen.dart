import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, this.email, this.password});
  final String? email;
  final String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
            CustomTextField(
              onChanged: (email) {
                email = email;
              },
              hintText: "Email",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              onChanged: (password) {
                password = password;
              },
              hintText: "Password",
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              title: "SignUp",
              onTap: () async {
                try {
                  FirebaseAuth auth = FirebaseAuth.instance;
                  await auth.createUserWithEmailAndPassword(
                    email: email!,
                    password: password!,
                  );
                } on FirebaseAuthException catch (ex) {
                  if (ex.code == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("weak-password"),
                      ),
                    );
                  } else if (ex.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("email-already-in-use"),
                      ),
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("success"),
                    ),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
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
