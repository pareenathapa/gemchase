// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/features/authentication/presentation/view_model/auth_view_model.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/utils/asset_provider.dart';
import '../../../../core/utils/util.dart';
import '../../../../screen/forget_password.dart';
import '../../../../screen/homepage.dart';
import 'register_view.dart';




class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool _isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override 
  void dispose() {
    _emailController.dispose(); 
    _passwordController.dispose();
    super.dispose();
  }

  // final _usernameController = TextEditingController();
  // final _passwordController = TextEditingController();
  final _gap = const SizedBox(height: 8);
  bool isObscure = true;
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
                Image.asset(Assets.images.Logo),
                // const LoginHeader(),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 24,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,),
                      ),
                      Text(
                        "Login to your account and enhance your memory.",
                        style: TextStyle(fontSize: 12,
                        color: Color(0xFF454C53),
                        fontWeight: FontWeight.w400,),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin,
                    vertical: kVerticalMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400,),
                      ),
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
                      const Text(
                        'Password',
                        style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400,),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "",
                          filled: true,
                          fillColor: const Color.fromARGB(15, 208, 130, 130),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kHorizontalMargin,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgetPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forget Password?",
                         style: TextStyle( fontSize: 14,
                          color: Color(0xFF0A0C0E),
                          fontWeight: FontWeight.w500,),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: kHorizontalMargin,
                      vertical: kVerticalMargin,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width * 2, height * 0.07),
                        backgroundColor: const Color.fromARGB(255, 77, 143, 177),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 24,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFCFCFC),),
                      ),
                      onPressed: () async{
                        if (_formKey.currentState?.validate() ?? false) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .login(
                                _emailController.text,
                                _passwordController.text,
                              );
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
                      const Text(
                        "Don’t have an account?",
                        style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0A0C0E),),
                      ),
                      SizedBox(width: width * 0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 77, 143, 177),),
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
