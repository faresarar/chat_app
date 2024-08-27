import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../cubits/sign_up_cubit.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? email;
  String? password;

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpSuccess) {
          Navigator.pushNamed(context, "ChatScreen");
          isLoading = false ;
        } else if (state is SignUpFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false ;
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
                    obscureText: true,
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
                        BlocProvider.of<SignUpCubit>(context).registerUser(
                          email: email!,
                          password: password!,
                        );
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context,
                              "LoginScreen");
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
      ),
    );
  }
}

