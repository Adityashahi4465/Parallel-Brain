import 'dart:ui';

import 'package:fintech/core/bg_image.dart';
import 'package:fintech/core/custom_text_field.dart';
import 'package:fintech/views/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String? _emailId;
  String? _password;
  final _emailIdController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Sign in with Email & Password
  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      handleError(e);
      return null;
    }
  }

  void handleError(FirebaseAuthException error) {
    setState(() {
      switch (error.code) {
        case 'user-not-found':
          errorMessage = 'User Not Found!';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong Password!';
          break;
        default:
          errorMessage = 'Error: ${error.message}';
      }
    });
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter Email!';
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'; // simpler regex
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Enter Valid Email!';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is empty!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          BackGroundImage(image: 'assets/background.jpg'),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                Text(
                  'Let\'s get Signed In',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),

                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: size.width * 0.80,

                      height: size.height * 0.30,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                            child: Container(),
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.13),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    //begin color
                                    Color.fromARGB(
                                      255,
                                      238,
                                      171,
                                      55,
                                    ).withOpacity(0.15),
                                    //end color
                                    Color.fromARGB(
                                      255,
                                      238,
                                      171,
                                      55,
                                    ).withOpacity(0.05),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //child ==> the first/top layer of stack
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Form(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    key: _formStateKey,
                                    child: Column(
                                      spacing: 16,
                                      children: <Widget>[
                                        CustomTextField(
                                          prefixIcon: Icons.mail,
                                          label: 'Email',
                                          height: 50,
                                          isPassword: false,
                                          controller: _emailIdController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomTextField(
                                          prefixIcon: Icons.mail,
                                          label: 'Password',
                                          height: 50,
                                          isPassword: false,
                                          controller: _passwordController,
                                          validator: (value) =>
                                              validatePassword(value),
                                        ),
                                      ],
                                    ),
                                  ),
                                  (errorMessage != ''
                                      ? Text(
                                          errorMessage,
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        )
                                      : Container()),
                                  OverflowBar(
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'LOGIN',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.green,
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_formStateKey.currentState!
                                              .validate()) {
                                            final email = _emailIdController
                                                .text
                                                .trim();
                                            final password = _passwordController
                                                .text
                                                .trim();

                                            signIn(email, password).then((
                                              user,
                                            ) {
                                              if (user != null) {
                                                print(
                                                  'Logged in successfully.',
                                                );
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        DashboardScreen(),
                                                  ),
                                                );
                                              } else {
                                                print('Error while Login.');
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          (successMessage != ''
                              ? Text(
                                  successMessage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                                )
                              : Container()),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
