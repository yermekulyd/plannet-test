import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/resources/auth_methods.dart';
import 'package:twitter_clone/theme/theme.dart';

import '../../../constants/constants.dart';
import '../../../core/utils.dart';
import '../../home/view/home_view.dart';
import '../widgets/auth_field.dart';

class LoginView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == 'Success') {
      showSnackBar(context, 'Login successfull');
      Navigator.pushAndRemoveUntil(
          context, HomeView.route(), false as RoutePredicate);
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const LoadingPage()
        : Scaffold(
            appBar: appBar,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      //Email Field
                      AuthField(
                        controller: emailController,
                        hintText: 'Email',
                      ),

                      const SizedBox(height: 25),

                      // Password Field
                      AuthField(
                        controller: passwordController,
                        hintText: 'Password',
                      ),

                      const SizedBox(height: 40),

                      // Button
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          onTap: loginUser,
                          label: 'Log In',
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Don't have account TextSpan
                      RichText(
                          text: TextSpan(
                        text: "Don't have an account?",
                        style: const TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                              text: " Sign up",
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to Sign Up Page
                                  Navigator.push(context, SignUpView.route());
                                }),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
