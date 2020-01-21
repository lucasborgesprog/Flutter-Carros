import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardtype;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final Icon icon;

  AppText(
    this.label,
    this.hint, {
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardtype,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype,
      textInputAction: textInputAction,
      validator: validator,
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        icon: icon,
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
