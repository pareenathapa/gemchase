import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:gemchase_clean_arch/core/utils/asset_provider.dart';
import 'package:gemchase_clean_arch/core/utils/util.dart';
import 'package:gemchase_clean_arch/core/constants/color_constants.dart';


class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final bool _isPasswordHidden = true;
  final bool _isCPasswordHidden = true;
  String? _password;
  String? _name;
  String? _phone;
  String? _email;

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.parse('http://localhost:5000/api/user/create');
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'name': _name!,
            'phone': _phone!,
            'email': _email!,
            'password': _password!,
          }),
        );

        if (response.statusCode == 200) {
          // Navigate or show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to register. Try again later.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

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
                      )
                    ],
                  ),
                ),
                // Additional input fields and registration button
                // ...
                Center(
                  child: ElevatedButton(
                    onPressed: _registerUser,
                    child: const Text('Register'),
                  ),
                ),
                // Other widgets...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
