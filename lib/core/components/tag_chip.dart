import 'package:flutter/material.dart';
import 'package:plie/core/constants/fonts_constants.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(color: Color(0xFFF5F7FC),borderRadius: BorderRadius.circular(12) ),
      child: Text(label, style: AppTextStyles.robotoRegular.copyWith(fontSize: 12),),
    );
  }
}
