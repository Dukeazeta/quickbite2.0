import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.errorText,
  });
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword && _obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          errorText: widget.errorText,
          filled: true,
          fillColor: Colors.grey[50],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
