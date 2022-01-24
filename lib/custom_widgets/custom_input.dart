import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {Key? key,
        this.emptyError = "",
        required this.hint,
        required this.keyboardType,
        this.maxLines,
        this.maxLength,
        this.prefixText,
        required this.onChanged,
        this.initialValue})
      : super(key: key);

  final String emptyError;
  final String hint;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? prefixText;
  final ValueChanged onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (emptyError != "") {
            if (value == null || value.isEmpty) {
              return emptyError;
            }
          }
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(width: 2)),
          prefixText: prefixText,
          hintText: hint,
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        initialValue: initialValue,
      ),
    );
  }
}
