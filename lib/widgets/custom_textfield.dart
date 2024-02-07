import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final bool? enabled;
  final bool readOnly;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.maxLength,
    this.maxLines,
    this.enabled,
    this.readOnly = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.grey,
      ),
      decoration: InputDecoration(
        counter: const SizedBox(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: labelText,
        errorMaxLines: 2,
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: InputBorder.none,
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
