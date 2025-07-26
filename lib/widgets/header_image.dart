import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  final double height;

  const HeaderImage({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png', // Caminho da sua imagem
      height: height,
      fit: BoxFit.contain,
    );
  }
}