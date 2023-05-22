import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  const TextFieldComponent({super.key, required this.hint, required this.ctr});
  final String hint;
  final TextEditingController ctr;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctr,
      decoration: InputDecoration(
          labelText: hint,
          enabledBorder: borderColorAndRadius(),
          border: InputBorder.none),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $hint";
        }
        return null;
      },
    );
  }

  OutlineInputBorder borderColorAndRadius({Color? errorColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1,
        color: errorColor ?? Colors.grey[200]!,
      ),
    );
  }
}
