import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Image.asset(kLogo),
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
                CustomTextFormField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  title: "SignUp",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushReplacementNamed(context, "ChatScreen");
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackBar(context, "weak-password");
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackBar(context, "email already in use");
                        }
                        isLoading = false;
                        setState(() {});
                        showSnackBar(context, "success");
                      }
                    } else {}
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
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
