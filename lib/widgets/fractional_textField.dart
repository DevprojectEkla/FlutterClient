import 'package:flutter/material.dart';


class FractionalWidthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String errorMessage;
  final bool obscureText;

  const FractionalWidthTextField({
    required this.controller,
    required this.labelText,
    required this.errorMessage,
    this.obscureText = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FractionallySizedBox(
        widthFactor: 1/3, // Takes one-third of the available width
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return errorMessage;
            }
            return null;
          },
            obscureText: obscureText,
        ),
      ),
    );
  }
}

