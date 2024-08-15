import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/jewelry/presentation/view_model/jewelry_view_model.dart';
import 'package:image_picker/image_picker.dart';

class JewelryCreateView extends ConsumerStatefulWidget {
  const JewelryCreateView({super.key});

  @override
  ConsumerState<JewelryCreateView> createState() => _JewelryCreateViewState();
}

class _JewelryCreateViewState extends ConsumerState<JewelryCreateView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String? _selectedCategory;
  final List<String> _categories = [
    'Necklaces',
    'Earrings',
    'Bangles',
    'Rings',
    'Bracelets',
  ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _createJewelry() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      final jewelryService = ref.read(jewelryViewModelProvider.notifier);
      final result = await jewelryService.create(
        name: _nameController.text,
        description: _descriptionController.text,
        price: _priceController.text,
        image: _imageFile!.path,
        category: _selectedCategory!,
        onError: (error) {
          showMySnackBar(message: error, color: Colors.red);
        },
        onSuccess: () {
          showMySnackBar(
            message: 'Jewelry created successfully!',
            color: Colors.green,
          );
        },
        navigation: () {
          Navigator.pop(context);
        },
      );
    } else {
      showMySnackBar(
        message: 'Please fill all fields and select an image',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Jewelry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  hint: 'Enter jewelry name',
                  icon: Icons.label,
                ),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'Enter jewelry description',
                  icon: Icons.description,
                ),
                _buildTextField(
                  controller: _priceController,
                  label: 'Price',
                  hint: 'Enter jewelry price',
                  icon: Icons.monetization_on,
                  inputType: TextInputType.number,
                ),
                _buildCategoryDropdown(),
                const SizedBox(height: 20),
                Center(
                  child: _imageFile == null
                      ? Column(
                          children: [
                            const Text(
                              'No image selected.',
                              style: TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: _pickImage,
                              icon: const Icon(Icons.image),
                              label: const Text('Pick Image'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                _imageFile!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              onPressed: _pickImage,
                              icon: const Icon(Icons.image),
                              label: const Text('Change Image'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ref.watch(jewelryViewModelProvider).isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _createJewelry,
                            child: const Text('Create Jewelry'),
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Category',
          prefixIcon: const Icon(Icons.category),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        value: _selectedCategory,
        items: _categories.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedCategory = value!;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
