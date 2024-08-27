import 'package:chat_app/cubits/login_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email;
  String? password;

  LoginScreen({super.key});
  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is LoginLoading){
          isLoading = true ;
        }
        else if (state is LoginSuccess){
          Navigator.pushNamed(context, "ChatScreen");
        }
        else if( state is LoginFailure){
          showSnackBar(context, "Something Went Wrong");
        }
      },
      child: ModalProgressHUD(
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
                    "Login",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextFormField(
                    hintText: "Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTextFormField(
                    obscureText: true,
                    hintText: "Password",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    title: "Login",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        try {
                          await loginUser();
                          Navigator.pushReplacementNamed(context, "ChatScreen",
                              arguments: email);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'weak-password') {
                            showSnackBar(context, "weak-password");
                          } else if (ex.code == 'wrong-password') {
                            showSnackBar(context, "wrong-password");
                          }
                          isLoading = false;
                          showSnackBar(context, "success");
                        }
                      } else {}
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, "SignUpScreen");
                        },
                        child: const Text(
                          "  SignUp",
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
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
      ),
    );
  }
}
