import 'package:flutter/material.dart';

class AddToCartBaseView extends StatefulWidget {
  const AddToCartBaseView({super.key});

  @override
  State<AddToCartBaseView> createState() => _AddToCartBaseViewState();
}

class _AddToCartBaseViewState extends State<AddToCartBaseView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Add to Cart view'),
      ),
    );
  }
}