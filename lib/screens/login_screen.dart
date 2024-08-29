import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/chat_cubit.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? email;
  String? password;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, "ChatScreen");
          isLoading = false ;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
          isLoading = false ;
        }
      },
      builder:(context,state) =>ModalProgressHUD(
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
                        BlocProvider.of<AuthCubit>(context).loginUser(
                          email: email!,
                          password: password!,
                        );
                      }
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
