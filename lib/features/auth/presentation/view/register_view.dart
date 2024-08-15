import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';

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

  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Create your account and experience the app.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF454C53),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : AssetImage(Assets.images.Logo) as ImageProvider,
                      child: _selectedImage == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputField(
                        label: 'First Name',
                        controller: _fnameController,
                        hintText: 'First Name',
                      ),
                      SizedBox(height: kHorizontalMargin),
                      _InputField(
                        label: 'Last Name',
                        controller: _lnameController,
                        hintText: 'Last Name',
                      ),
                      SizedBox(height: kHorizontalMargin),
                      _InputField(
                        label: 'Email',
                        controller: _emailController,
                        hintText: 'someone@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      SizedBox(height: kHorizontalMargin),
                      _PasswordInputField(
                        label: 'Password',
                        controller: _passwordController,
                        isHidden: _isPasswordHidden,
                        onToggleVisibility: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                      SizedBox(height: kHorizontalMargin),
                      _PasswordInputField(
                        label: 'Confirm Password',
                        controller: _confirmPasswordController,
                        isHidden: _isCPasswordHidden,
                        onToggleVisibility: () {
                          setState(() {
                            _isCPasswordHidden = !_isCPasswordHidden;
                          });
                        },
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.8, height * 0.07),
                              backgroundColor:
                                  const Color.fromARGB(255, 77, 143, 177),
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
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .register(
                                      firstName: _fnameController.text,
                                      lastName: _lnameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      confirmPassword:
                                          _confirmPasswordController.text,
                                      image: _selectedImage,
                                      onError: (error) {
                                        showMySnackBar(
                                          message: error.toString(),
                                          color: Colors.red,
                                        );
                                      },
                                      onSuccess: () {
                                        showMySnackBar(
                                          message: 'Registration successful',
                                          color: Colors.green,
                                        );
                                      },
                                      // ! COMMENTED OUT FOR TESTING
                                      navigation: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const LoginView(),
                                          ),
                                        );
                                      },
                                    );
                              }
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF0A0C0E),
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 77, 143, 177),
                              ),
                            ),
                          ),
                        ],
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

  static String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.controller,
    this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: const Color(0x0fffffff),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: validator,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}

class _PasswordInputField extends StatelessWidget {
  const _PasswordInputField({
    required this.label,
    required this.controller,
    required this.isHidden,
    required this.onToggleVisibility,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final bool isHidden;
  final VoidCallback onToggleVisibility;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "",
            filled: true,
            fillColor: const Color(0x0fffffff),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
              onPressed: onToggleVisibility,
            ),
          ),
          obscureText: isHidden,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
        ),
      ],
    );
  }
}
