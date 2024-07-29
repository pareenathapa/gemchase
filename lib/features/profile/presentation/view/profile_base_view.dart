import 'package:flutter/material.dart';

class ProfileBaseView extends StatefulWidget {
  const ProfileBaseView({super.key});

  @override
  State<ProfileBaseView> createState() => _ProfileBaseViewState();
}

class _ProfileBaseViewState extends State<ProfileBaseView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}