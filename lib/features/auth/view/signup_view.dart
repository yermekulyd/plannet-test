import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/resources/auth_methods.dart';

import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

class SignUpView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final appBar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        file: _image!);

    if (res == 'Success') {
      showSnackBar(context, 'Account has been created! Please log in');
      Navigator.push(context, LoginView.route());
    } else {
      showSnackBar(context, res);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);

    setState(() {
      _image = image;
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
                      // Circular Avatar
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 64,
                                  backgroundImage: MemoryImage(_image!))
                              : const CircleAvatar(
                                  radius: 64,
                                  backgroundImage: NetworkImage(
                                      'https://mybroadband.co.za/news/wp-content/uploads/2017/04/Twitter-profile-picture.jpg'),
                                ),
                          Positioned(
                            bottom: -10,
                            right: 0,
                            child: IconButton(
                              onPressed: selectImage,
                              icon: const Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 40,
                      ),

                      // Email Field
                      AuthField(
                        controller: emailController,
                        hintText: 'Email',
                      ),

                      const SizedBox(height: 25),

                      // Username field
                      AuthField(
                        controller: usernameController,
                        hintText: 'Username',
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
                          onTap: signUpUser,
                          label: 'Sign Up',
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Already have account TextSpan
                      RichText(
                          text: TextSpan(
                        text: "Already have an account?",
                        style: const TextStyle(fontSize: 16),
                        children: [
                          TextSpan(
                              text: " Log in",
                              style: const TextStyle(
                                color: Pallete.blueColor,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Navigate to Log In Page
                                  Navigator.push(context, LoginView.route());
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
