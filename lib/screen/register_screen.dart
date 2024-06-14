import 'package:flutter/material.dart';
import 'package:student_management_starter/core/constants/color_constants.dart';
import 'package:student_management_starter/core/utils/asset_provider.dart';
import 'package:student_management_starter/core/utils/util.dart';
import 'package:student_management_starter/screen/login_screen.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  bool _isCPasswordHidden = true;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kBackground),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Assets.images.Logo),
                
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin,
                  ),
                  child: const Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                           fontSize: 24,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        )
                      ),
                      Text(
                        "Create you account and experience the app.",
                        style: TextStyle(
                          fontSize: 12,
                        color: Color(0xFF454C53),
                        fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: kHorizontalMargin, vertical: kVerticalMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Test User 01",
                          filled: true,
                          fillColor: const Color(0xFFFFFFF),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: kHorizontalMargin,
                      ),
                      const Text(
                        'Phone No.',
                        style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "9800000000",
                          filled: true,
                          fillColor: const Color(0xFFFFFFF),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                            return 'Please enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: kHorizontalMargin,
                      ),
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18,
                        fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "someone@gmail.com",
                          filled: true,
                          fillColor: const Color(0xFFFFFFF),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: kHorizontalMargin,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400,),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "",
                          filled: true,
                          fillColor: const Color(0xFFFFFFF),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                        ),
                        obscureText: _isPasswordHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          _password = value;
                          return null;
                        },
                      ),
                      SizedBox(
                        height: kHorizontalMargin,
                      ),
                      const Text(
                        'Confirm Password',
                        style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400,)
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "",
                          filled: true,
                          fillColor: const Color.fromARGB(15, 111, 159, 192),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          suffixIcon: IconButton(
                            icon: Icon(_isCPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isCPasswordHidden = !_isCPasswordHidden;
                              });
                            },
                          ),
                        ),
                        obscureText: _isCPasswordHidden,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      Center(
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: kVerticalMargin),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 2, height * 0.07),
                              backgroundColor:  const Color.fromARGB(255, 77, 143, 177),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                fontSize: 24,
                              fontFamily: 'Times',
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFCFCFC),

                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform registration logic
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: const Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0A0C0E),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                );
                              },
                              child: const Text(
                                "Login",
                               style: TextStyle( fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color:  Color.fromARGB(255, 77, 143, 177),),
                                
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
