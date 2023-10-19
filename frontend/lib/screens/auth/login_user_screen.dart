import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api/auth_services.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/widgets/custom_text_field.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({super.key});

  @override
  State<LoginUserScreen> createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.08, horizontal: size.width * 0.1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Social App",
                    style: TextStyle(
                      color: ColorConstants.lightWhiteColor,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.07,
                  ),
                  const Text(
                    "Welcome Back,\nSign In to your account",
                    style: TextStyle(
                      color: ColorConstants.greyColor,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: ColorConstants.greyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                              color: ColorConstants.yelloColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  //
                  // DEFINED UNDER WIDGETS/CUSTOM_TEXT_FIELD.DART file
                  //
                  CustomTextField(
                    title: "Email",
                    controller: emailController,
                    isObscure: false,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomTextField(
                    title: "Password",
                    controller: passwordController,
                    isObscure: true,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.35,
              ),
              Container(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    if (passwordController.text.isEmpty ||
                        emailController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Enter valid credentials");
                    } else {
                      AuthServices.loginUser(emailController.text,
                          passwordController.text, context);
                    }
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.yelloColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
