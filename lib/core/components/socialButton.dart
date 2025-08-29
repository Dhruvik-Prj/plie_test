import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  const SocialButton(
      {super.key, required this.assetPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Image.asset(assetPath, height: 24, width: 24),
      ),
    );
  }
}
