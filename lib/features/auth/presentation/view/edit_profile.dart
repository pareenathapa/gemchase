import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // Load existing user data here and set it to the controllers
    // Example:
    _fnameController.text =
        ref.read(authViewModelProvider).loginEntity!.user!.firstName!;
    _lnameController.text =
        ref.read(authViewModelProvider).loginEntity!.user!.lastName!;
    _emailController.text =
        ref.read(authViewModelProvider).loginEntity!.user!.email!;
    // _selectedImage = ref.read(authViewModelProvider).loginEntity!.user!.email!;
  }

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
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      width: width * 0.3,
                      height: width * 0.3,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : NetworkImage(
                                  "${ApiEndpoints.url}/${ref.read(authViewModelProvider).loginEntity!.user!.image??""}",
                                ) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
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
                      SizedBox(height: height * 0.02),
                      _InputField(
                        label: 'Last Name',
                        controller: _lnameController,
                        hintText: 'Last Name',
                      ),
                      SizedBox(height: height * 0.02),
                      _InputField(
                        label: 'Email',
                        controller: _emailController,
                        hintText: 'someone@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
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
                              "SAVE",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFCFCFC),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .updateUser(
                                      userId: ref
                                          .read(authViewModelProvider)
                                          .loginEntity!
                                          .user!
                                          .id!,
                                      firstName: _fnameController.text,
                                      lastName: _lnameController.text,
                                      email: _emailController.text,
                                      image: _selectedImage,
                                      onError: (error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(error.toString()),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      onSuccess: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Profile updated successfully'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      },
                                    );
                              }
                            },
                          ),
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
