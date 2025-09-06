import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final double height;
  final bool isPassword;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    required this.height,
    required this.isPassword,
    required this.validator,
    required this.controller,
    this.suffixIcon,
    this.onSuffixIconPressed,
    required this.prefixIcon,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        autofocus: false,
        textAlignVertical: TextAlignVertical.top,
        obscureText: widget.isPassword ? isObscure : false,
        validator: widget.validator,
        style: const TextStyle(
          color: Colors.orange, // Input text color
          fontSize: 16,
        ),
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.orange, // Label color
            fontSize: 16,
          ),
          prefixIcon: widget.prefixIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Icon(
                    widget.prefixIcon,
                    color: Colors.orange, // Prefix icon color
                  ),
                ),
          label: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(widget.label),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9), // White-ish background
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: isObscure
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  color: Colors.orange,
                  onPressed: () => setState(() => isObscure = !isObscure),
                )
              : IconButton(
                  onPressed: widget.onSuffixIconPressed,
                  icon: widget.suffixIcon ?? const SizedBox(),
                ),
          prefixIconColor: Colors.orange,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange.withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
