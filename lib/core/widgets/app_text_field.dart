import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    super.key,
    this.controller,
    this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.textInputAction,
    this.validator,
  });

  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final String label;
  final int maxLines;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hint, labelText: label),
      keyboardType: keyboardType,
      maxLines: maxLines,
      textInputAction: textInputAction,
      validator: validator,
    );
  }
}
