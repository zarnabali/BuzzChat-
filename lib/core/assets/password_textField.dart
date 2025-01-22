import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String text;

  const PasswordField(
      {super.key, required this.controller, required this.text});

  @override
  _PasswordField createState() => _PasswordField();
}

class _PasswordField extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.text,
        hintStyle: GoogleFonts.robotoMono(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        suffixIcon: IconButton(
          icon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.black),
          ),
          onPressed: _toggleVisibility,
        ),
      ),
      style: GoogleFonts.robotoMono(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.normal),
    );
  }
}
