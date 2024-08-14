import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:gemchase_clean_arch/features/jewelry/presentation/view_model/jewelry_view_model.dart';
import 'package:image_picker/image_picker.dart';

class JewelryEditView extends ConsumerStatefulWidget {
  final JewelryModel jewelry;

  const JewelryEditView({required this.jewelry, super.key});

  @override
  ConsumerState<JewelryEditView> createState() => _JewelryEditViewState();
}

class _JewelryEditViewState extends ConsumerState<JewelryEditView> {
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
    'Nose Ring', // Ensure this category is included if it exists in your data
  ];

  @override
  void initState() {
    super.initState();
    // Pre-fill form fields with existing jewelry data
    _nameController.text = widget.jewelry.jewelryName ?? '';
    _descriptionController.text = widget.jewelry.jewelryDescription ?? '';
    _priceController.text = widget.jewelry.jewelryPrice.toString();
    _selectedCategory = widget.jewelry.jewelryCategory ?? '';

    // Ensure the selected category exists in the list
    if (!_categories.contains(_selectedCategory)) {
      _categories.add(_selectedCategory!);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateJewelry() async {
    if (_formKey.currentState!.validate()) {
      final jewelryService = ref.read(jewelryViewModelProvider.notifier);
      final result = await jewelryService.update(
        id: widget.jewelry.id ??
            "", // Assuming there's an ID in your JewelryModel
        name: _nameController.text,
        description: _descriptionController.text,
        price: _priceController.text,
        image: _imageFile?.path ??
            widget.jewelry.jewelryImage ??
            "", // Use the new image if selected
        category: _selectedCategory!,
        onError: (error) {
          showMySnackBar(message: error, color: Colors.red);
        },
        onSuccess: () {
          showMySnackBar(
            message: 'Jewelry updated successfully!',
            color: Colors.green,
          );
          jewelryService.getAll();
        },
        navigation: () {
          Navigator.pop(context);
        },
      );
    } else {
      showMySnackBar(
        message: 'Please fill all fields',
        color: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Jewelry'),
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
                  child: _imageFile == null &&
                          widget.jewelry.jewelryImage != null
                      ? Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                '${ApiEndpoints.url}/${widget.jewelry.jewelryImage}',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error),
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
                        )
                      : Column(
                          children: [
                            _imageFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      _imageFile!,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Text('No image selected.'),
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
                        ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ref.watch(jewelryViewModelProvider).isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _updateJewelry,
                            child: const Text('Update Jewelry'),
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
