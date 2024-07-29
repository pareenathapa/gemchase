import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/constants/color_constants.dart';
import 'package:gemchase_clean_arch/core/utils/asset_provider.dart';
import 'package:gemchase_clean_arch/core/utils/util.dart';
import 'package:gemchase_clean_arch/features/authentication/domain/entity/auth_entity.dart';
import 'package:gemchase_clean_arch/features/authentication/presentation/view_model/auth_view_model.dart';
import 'login_view.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  bool _isCPasswordHidden = true;
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(kBackground),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Assets.images.Logo, height: 150, width: 500),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(fontSize: 24, fontFamily: 'Times', fontWeight: FontWeight.w400, color: Colors.black),
                      ),
                      Text(
                        "Create your account and experience the app.",
                        style: TextStyle(fontSize: 12, color: Color(0xFF454C53), fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kHorizontalMargin, vertical: kVerticalMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('First Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                      TextFormField(
                        controller: _fnameController,
                        decoration: InputDecoration(
                          hintText: "First Name",
                          filled: true,
                          fillColor: const Color(0x0fffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: kHorizontalMargin),
                      const Text('Last Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                      TextFormField(
                        controller: _lnameController,
                        decoration: InputDecoration(
                          hintText: "Last Name",
                          filled: true,
                          fillColor: const Color(0x0fffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: kHorizontalMargin),
                      const Text('Email', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "someone@gmail.com",
                          filled: true,
                          fillColor: const Color(0x0fffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                      SizedBox(height: kHorizontalMargin),
                      const Text('Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "",
                          filled: true,
                          fillColor: const Color(0x0fffffff),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordHidden ? Icons.visibility : Icons.visibility_off),
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
                          return null;
                        },
                      ),
                      SizedBox(height: kHorizontalMargin),
                      const Text('Confirm Password', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          hintText: "",
                          filled: true,
                          fillColor: const Color.fromARGB(15, 111, 159, 192),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isCPasswordHidden ? Icons.visibility : Icons.visibility_off),
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
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: kVerticalMargin),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.8, height * 0.07),
                              backgroundColor: const Color.fromARGB(255, 77, 143, 177),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(fontSize: 24, fontFamily: 'Times', fontWeight: FontWeight.w400, color: Color(0xFFFCFCFC)),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var user = AuthEntity(
                                  firstName: _fnameController.text,
                                  lastName: _lnameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  confirmpassword: _confirmPasswordController.text,
                                );
                                ref.read(authViewModelProvider.notifier).register(user);
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text(
                                "Already have an account?",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF0A0C0E)),
                              ),
                            ),
                            SizedBox(width: width * 0.02),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView()));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 77, 143, 177)),
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
