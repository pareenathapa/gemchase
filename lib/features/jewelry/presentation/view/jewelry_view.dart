import 'package:flutter/material.dart';

class JewelryView extends StatefulWidget {
  const JewelryView({super.key});

  @override
  State<JewelryView> createState() => _JewelryViewState();
}

class _JewelryViewState extends State<JewelryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JewelryView'),
      ),
      body: const Center(
        child: Text('JewelryView'),
      ),
    );
  }
}
