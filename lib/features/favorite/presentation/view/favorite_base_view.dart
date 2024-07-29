import 'package:flutter/material.dart';

class FavoriteBaseView extends StatefulWidget {
  const FavoriteBaseView({super.key});

  @override
  State<FavoriteBaseView> createState() => _FavoriteBaseViewState();
}

class _FavoriteBaseViewState extends State<FavoriteBaseView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Favorite Screen'),
      ),
    );
  }
}